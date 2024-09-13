# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "/payments", type: :request do
  let(:user) { create(:user) }
  let(:source_account) { create(:account, user: user, amount: 100) }
  let(:destination_account) { create(:account, user: user, amount: 0) }
  let(:valid_attributes) do
    {
      source_account_id: source_account.id,
      destination_account_id: destination_account.id,
      amount: 50
    }
  end

  let(:invalid_attributes) do
    {
      source_account_id: source_account.id,
      destination_account_id: destination_account.id,
      amount: 150
    }
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_payment_url(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Payment" do
        expect {
          post user_payments_url(user), params: { payment: valid_attributes }
        }.to change(Payment, :count).by(1)
      end

      it "redirects to the source account" do
        post user_payments_url(user), params: { payment: valid_attributes }
        expect(response).to redirect_to(user_account_path(user, source_account))
      end

      it "updates account balances" do
        post user_payments_url(user), params: { payment: valid_attributes }
        expect(source_account.reload.amount).to eq(50)
        expect(destination_account.reload.amount).to eq(50)
      end

      it "creates a cashback account if it doesn't exist" do
        expect {
          post user_payments_url(user), params: { payment: valid_attributes }
        }.to change { user.accounts.cashback.count }.by(1)
      end

      it "adds cashback to the cashback account" do
        post user_payments_url(user), params: { payment: valid_attributes }
        cashback_account = user.accounts.cashback.first
        expect(cashback_account.amount).to eq(2.5) # 5% of 50
      end
    end

    context "with invalid parameters" do
      it "does not create a new Payment" do
        expect {
          post user_payments_url(user), params: { payment: invalid_attributes }
        }.to change(Payment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_payments_url(user), params: { payment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end