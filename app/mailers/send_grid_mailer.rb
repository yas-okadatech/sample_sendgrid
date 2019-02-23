# frozen_string_literal: true

class SendGridMailer < ApplicationMailer
  def hello
    mail(subject: 'hello', to: ENV['SENGDRID_TO'])
  end

  def with_template
    xsmtp_api_params = {
      personalizations: {
        dynamic_template_data: {
          name: 'Alice'
        }
      },
      template_id: ENV['SENDGRID_TEMPLATE_ID']
    }
    headers['X-SMTPAPI'] = xsmtp_api_params.to_json
    mail(subject: 'hello', body: 'test', to: ENV['SENGDRID_TO'])
  end
end
