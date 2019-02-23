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
    xsmtp_api_params = {
      to: [
        ENV['SENGDRID_TO']
      ],
      sub: {
        ':name': [
          'Alice'
        ]
      },
      filters: {
        templates: {
          settings: {
            enable: 1,
            template_id: ENV['SENDGRID_LEGACY_TEMPLATE_ID']
          }
        }
      }
    }

    headers['X-SMTPAPI'] = xsmtp_api_params.to_json
    mail(subject: 'hello', body: '', to: ENV['SENGDRID_TO_DUMMY'])
  end
end
