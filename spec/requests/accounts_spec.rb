# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/accounts', type: :request do
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :account, user: }

  let(:invalid_attributes) { { amount: nil } }

  describe 'GET /show' do
    it 'renders a successful response' do
      account = Account.create! valid_attributes
      get user_account_url(user, account)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_account_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      account = Account.create! valid_attributes
      get edit_user_account_url(user, account)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Account' do
        expect do
          post user_accounts_url(user), params: { account: valid_attributes }
        end.to change(Account, :count).by(1)
      end

      it 'redirects to the created account' do
        post user_accounts_url(user), params: { account: valid_attributes }
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Account' do
        expect do
          post user_accounts_url(user), params: { account: invalid_attributes }
        end.to change(Account, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_accounts_url(user), params: { account: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested account' do
        account = Account.create! valid_attributes
        patch user_account_url(user, account), params: { account: new_attributes }
        account.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the account' do
        account = Account.create! valid_attributes
        patch user_account_url(user, account), params: { account: new_attributes }
        account.reload
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        account = Account.create! valid_attributes
        patch user_account_url(user, account), params: { account: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested account' do
      account = Account.create! valid_attributes
      expect do
        delete user_account_url(user, account)
      end.to change(Account, :count).by(-1)
    end

    it 'redirects to the accounts list' do
      account = Account.create! valid_attributes
      delete user_account_url(user, account)
      expect(response).to redirect_to(user_url(user))
    end
  end
end
