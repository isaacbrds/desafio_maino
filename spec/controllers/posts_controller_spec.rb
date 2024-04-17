# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context 'GET #index' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    it 'renders the index template' do
      sign_in(user)
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  context 'GET #show' do
    let(:post) { create(:post) }
    it 'renders the show template' do
      get :show, params: { id: post.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template('show')
    end

    it 'renders this post' do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  context 'GET #new' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    it 'renders the new template' do
      sign_in user
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  context 'POST #create' do
    let(:user) { create(:user) }
    let!(:params) do
      { title: 'Meu Post', content: 'Meu post maroto', user_id: user.id }
    end
    it 'render succeful message' do
      sign_in user
      post :create, params: { post: params }
      expect(flash[:notice]).to eq('O post foi criado com sucesso')
      expect(response).to have_http_status(302)
    end

    it 'not create a post' do
      sign_in user
      params = { title: 'Meu Post' }
      post :create, params: { post: params }
      expect(response).to render_template(:new)
    end
  end

  context 'GET #edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    it 'renders the edit template' do
      sign_in user
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template('edit')
    end
  end

  context 'PUT #update' do
    let(:user) { create(:user) }
    let!(:post)  do
      create(:post, user_id: user.id)
    end
    it 'render succeful message' do
      params = { title: 'Meu post atualizado' }
      sign_in user
      put :update, params: { id: post.id, post: params }
      post.reload
      expect(post.title).to eq(params[:title])
      expect(flash[:notice]).to eq('O post foi atualizado com sucesso')
    end

    it 'not update a post' do
      sign_in user
      params = { title: nil }
      put :update, params: { id: post.id, post: params }
      expect(response).to render_template(:edit)
    end
  end

  context 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:post)  do
      create(:post, user_id: user.id)
    end
    it 'render succeful message' do
      sign_in user
      delete :destroy, params: { id: post.id }
      expect(flash[:notice]).to eq('O post foi destruído com sucesso')
    end
  end
end
