# frozen_string_literal: true

class SendGridMailer < ApplicationMailer
  def hello
    mail(subject: 'hello', to: ENV['SENGDRID_TO'])
  end
end
