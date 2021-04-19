class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update]

  def edit
  end

  def update
    @account.update(theme_param)
    redirect_to privacy_users_path
  end

  private

  def set_account
    @account = current_user.account
    authorize @account
  end

  def theme_param
    params.require(:account).permit(:theme)
  end
end
