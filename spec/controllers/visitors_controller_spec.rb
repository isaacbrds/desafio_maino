
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @current_user = create(:user)
  end
  
  context 'GET #index' do
    let(:post) { create(:post, user_id: @current_user.id) }
    
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, faça login ou registre-se.')
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
    let(:post) { create(:post) }
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, faça login ou registre-se.')
    end
  end

  context 'GET #edit' do
    let(:post) { create(:post, user_id: @current_user.id) }
    it 'renders the edit template' do
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Você não tem permissão para editar isso')
    end
  end

  context 'DELETE #destroy' do
    let!(:post)  do
      create(:post, user_id: @current_user.id)
    end
    it 'render succeful message' do
      delete :destroy, params: { id: post.id }
      expect(flash[:alert]).to eq('Você não tem permissão para editar isso')
    end
  end
end

