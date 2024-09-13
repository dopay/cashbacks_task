# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let!(:transaction) { create(:transaction, account: account) }

  describe "GET /users/:user_id/accounts/:account_id/transactions" do
    it "returns http success" do
      get user_account_transactions_path(user, account)
      expect(response).to have_http_status(:success)
    end

    it "displays the transaction" do
      get user_account_transactions_path(user, account)
      expect(response.body).to include(transaction.amount.to_s)
      expect(response.body).to include(transaction.transaction_type)
    end
  end
end