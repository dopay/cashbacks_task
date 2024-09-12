# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :load_user
  before_action :load_account

  def index
    @transactions = @account.transactions.order(created_at: :desc)
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_account
    @account = @user.accounts.find(params[:account_id])
  end
end