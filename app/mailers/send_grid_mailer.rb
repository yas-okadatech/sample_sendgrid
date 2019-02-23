# frozen_string_literal: true

class SendGridMailer < ApplicationMailer
  def hello
    mail(subject: 'hello', to: ENV['SENGDRID_TO'])
  end

  def by_template
    # TODO: あとで Web API v3 で使う
    # xsmtp_api_params = {
    #     from: {
    #         email: 'sample_sendgrid@example.com'
    #     },
    #     personalizations: [
    #         {
    #             to: [
    #                 { enail: ENV['SENGDRID_TO'] }
    #             ],
    #             dynamic_template_data: {
    #                 name: 'Alice'
    #             },
    #         }
    #     ],
    #     template_id: ENV['SENDGRID_TEMPLATE_ID']
    # }

    headers['X-SMTPAPI'] = create_xsmtp_api_params.to_json
    mail(subject: 'hello3', body: '', to: 'dummy@example.com')
  end

  private

  def create_xsmtp_api_params
    emails = load_data['emails']
    to = emails.map { |email| email['address'] }
    name = emails.map { |email| email['name'] }

    {
      to: to,
      sub: {
        ':name': name
      },
      filters: filters
    }
  end

  def load_data
    YAML.safe_load(File.open(Rails.root.join('maillist.yml')))
  end

  def filters
    {
      templates: {
        settings: {
          enable: 1,
          template_id: ENV['SENDGRID_LEGACY_TEMPLATE_ID']
        }
      }
    }
  end
end
