# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:valid_attributes) { attributes_for :user }

  let(:invalid_attributes) { { email: '' } }

  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post users_url, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'new_name' } }

      it 'updates the requested user' do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: new_attributes }
        user.reload
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect do
        delete user_url(user)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
