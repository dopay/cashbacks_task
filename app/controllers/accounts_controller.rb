# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :load_user
  before_action :load_account, only: %i[show edit update destroy]

  attr_reader :user, :account

  def show; end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = user.accounts.new account_params

    if @account.save
      redirect_to user_path(user), notice: 'Account was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      redirect_to user_path(user), notice: 'Account was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy

    redirect_to user_url(user), notice: 'Account was successfully destroyed.'
  end

  private

  def load_user
    @user = User.find params[:user_id]
  end

  def load_account
    @account = user.accounts.find params[:id]
  end

  def account_params
    params.require(:account).permit :name, :amount
  end
end
