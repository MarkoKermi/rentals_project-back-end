# frozen_string_literal: true

# Creates the aplicationMailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
