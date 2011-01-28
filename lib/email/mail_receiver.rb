require 'mail'
require 'mms2r'
class MailReceiver
#attr_accessible :from_user, :tags, :comment,:date, :contents
  def initialize
    Mail.defaults do
      retriever_method :pop3, {:address    => "pop.gmail.com",
                               :port       => 995,
                               :user_name  => 'expenza.inc',
                               :password   => '',
                               :enable_ssl => true}
    end
  end

  def receive_email
    email = Mail.last || []
    puts "#{email.inspect}"
    if (email.instance_of?(Array) && email.empty?)
      return nil
    else
      mms = MMS2R::Media.new(email)
      @mailtxt = ""
      @contents    = ""
      @mailtxt = IO.readlines(mms.media['text/plain'].first).join unless mms.media['text/plain'].nil?
      if (email.attachments.length > 0) #If no attachment, treat the mail text as receipt
        @contents = mms.media.delete_if { |key, value| key =~ /^text/ }
      else
        @contents = mms.media
      end
      return {
          :from_user          => email.from[0],
          :tags               => email.subject,
          :date               => email.date,
          :contents           => @contents,
          :comment            => @mailtxt
      }
    end
  end
end
#attachment = mms.default_media
#puts "Mail subject: #{email.subject}"
#puts "Mail Body : #{email.body.decoded}"
#puts "mail had a media: #{attachment.inspect}" unless attachment.nil?
#puts "#{mms.media.inspect}"


#a = MailReceiver.new
#a.receive_email
