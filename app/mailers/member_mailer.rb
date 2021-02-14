class MemberMailer < ApplicationMailer
  helper :items
  helper :members
  helper :date
  helper :holds
  helper :admin

  before_action :generate_uuid
  after_action :set_uuid_header
  after_action :store_notification

  def welcome_message
    @member = params[:member]
    @library = @member.library
    @amount = Money.new(params[:amount]) if params.key?(:amount)
    @subject = "Welcome to The #{@library.name}"
    mail(to: @member.email, subject: @subject)
  end

  def renewal_message
    @member = params[:member]
    @amount = Money.new(params[:amount]) if params.key?(:amount)
    @subject = "Your membership to The Chicago Tool Library has been renewed"
    mail(to: @member.email, subject: @subject)
  end

  def membership_reminder
    @member = params[:member]
    @library = @member.library
    @subject = "Don't forget to to activate your membership!"
    mail(to: @member.email, subject: @subject)
  end

  def loan_summaries
    @subject = "Today's loan summary"
    summary_mail
  end

  def overdue_notice
    @subject = "You have overdue items!"
    @warning = "Please return all overdue items as soon as possible so other members can check them out."
    summary_mail
  end

  def return_reminder
    @subject = "Your items are due soon"
    summary_mail
  end

  def loan_renewal_request_message
    # TODO: Implement
    @subject = "Renewal Request"
  end

  def membership_renewal_reminder
    @member = params[:member]
    @amount = params[:amount] || Money.new(0)
    @subject = "Inviting you to renew and reconnect with the Chicago Tool Library in 2021!"
    mail(to: @member.email, subject: @subject)
  end

  private

  def summary_mail
    @member = params[:member]
    @library = @member.library
    @summaries = params[:summaries]
    @now = params[:now] || Time.current

    mail(to: @member.email, subject: @subject, template_name: "summary")
  end

  def generate_uuid
    @uuid = SecureRandom.uuid
  end

  def set_uuid_header
    headers["X-SMTPAPI"] = {
      unique_args: {
        uuid: @uuid
      }
    }.to_json
  end

  def store_notification
    Notification.create!(member: @member, uuid: @uuid, action: action_name, address: @member.email, subject: @subject, library: @library)
  end
end
