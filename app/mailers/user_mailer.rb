class UserMailer < ApplicationMailer

  # Send an email which contains a link that the user can
  # click in order to activate their account.
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Send an email which the user can use to start the
  # password reset process.
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
