# frozen_string_literal: true

class SendGridService
  def send
    mail = create_mail_helper

    emails = load_data['emails']
    emails.each do |email|
      mail.add_personalization(create_personalization(email))
    end

    send_mail mail
  end

  private

  def load_data
    YAML.safe_load(File.open(Rails.root.join('maillist.yml')))
  end

  def create_mail_helper
    mail = SendGrid::Mail.new
    mail.template_id = ENV['SENDGRID_DYNAMIC_TEMPLATE_ID']
    mail.from = SendGrid::Email.new(email: 'sample_sendgrid@example.com')
    mail
  end

  def create_personalization(email)
    personalization = SendGrid::Personalization.new
    to = SendGrid::Email.new(email: email['address'])
    personalization.add_to(to)

    variable = { name: email['name'] }
    personalization.add_dynamic_template_data(variable)
    personalization
  end

  def send_mail(mail)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts "status: #{response.status_code}"
  end
end
