require 'rufus/scheduler'
require 'email/mail_receiver'
desc 'Check email and place them in the delayed job que'
task :check_email => :environment do
  scheduler = Rufus::Scheduler.start_new
  mr = MailReceiver.new
  scheduler.every '10s' do
    ml = mr.receive_email
    if !ml.nil?
      emp = EmailParser.new(ml)
      emp.parse_save_email
      puts "Job in queue"
    end
  end
  scheduler.join
end
