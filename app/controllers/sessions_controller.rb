# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  skip_after_filter :store_location
  before_filter :ensure_user, :only => [:new]
  before_filter :check_agreement, :only => [:new]

  # /login
  def new
    if current_user
      notice_stickie I18n.t("user.notice.login_success")
    end
    session[:return_to] = params[:return_to] if params[:return_to].present?
    redirect_back_or_default(root_url)
  end

  # /logout
  def destroy
    st = session[:cas_last_valid_ticket]
    CASClient::Frameworks::Rails::Filter.send(:delete_service_session_lookup, st) unless st.blank?
    logout_killing_session!
    notice_stickie I18n.t("user.notice.logout_success")
    params[:return_to] = root_url if params[:return_to] =~ /\/admin/i
    redirect_to(CASClient::Frameworks::Rails::Filter.client.logout_url(nil, params[:return_to] || request.referrer))
  end

  # /sync
  def sync
    unless logged_in?
      CASClient::Frameworks::Rails::Filter.filter(self)
    end

    @cas_is_login = params[:ticket] ? true : false;
    if @cas_is_login
      if !logged_in?
        @local_should_reauthenticate = true
      elsif params[:login].blank?
        @local_should_reauthenticate = true
      elsif current_user.login != params[:login]
        st = session[:cas_last_valid_ticket]
        CASClient::Frameworks::Rails::Filter.send(:delete_service_session_lookup, st) unless st.blank?
        logout_killing_session!
        @local_should_reauthenticate = true
      end
    else
      if logged_in?
        @local_should_logout = true
      end
    end
  end

  protected

  def ensure_user
    unless logged_in?
      return CASClient::Frameworks::Rails::Filter.filter(self)
    end
  end

  def check_agreement
    return if current_user && current_user.is_agreed
    notice_stickie I18n.t("user.notice.login_success")
    session[:return_to] = params[:return_to] if params[:return_to].present?
    redirect_to agree_user_path(current_user)
  end
end
