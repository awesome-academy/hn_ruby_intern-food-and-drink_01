class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notification.subject
  #
  def notification order
    @user = User.find_by id: order.user_id
    @order = order
    mail to: @user.email, subject: t(".sub")
  end
end
