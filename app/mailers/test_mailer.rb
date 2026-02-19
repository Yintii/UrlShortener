class TestMailer < ApplicationMailer
  default from: 'accounts@yintii.com'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'kh@yintii.com',
      from: 'accounts@yintii.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end