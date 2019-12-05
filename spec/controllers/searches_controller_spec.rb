require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
    describe 'new' do
        render_views
        let!(:auths){Auth.create!(:username =>"328",:role => "S",:password =>'k')}
        let!(:users){User.create!(:uin => 328)}
        def test
          post 'new',{:session => {:user => 328}}  
        end
        it 'renders to Main search' do
            get :new
            expect(response).to render_template('searches/new')
        end
        it 'checks  authentication for student' do
            session[:user] = "328"
            get :new
            expect(response).to redirect_to(search_path("S",:uin =>session[:user]))
        end
    end
    describe 'index' do
        let!(:auths){Auth.create!(:username =>"328",:role => "S",:password =>'k')}
        let!(:users){User.create!(:uin => 328)}
        let!(:reviews){Review.create!(:user_id => 328 ,:year => 2020)}
        
        it 'redirects to index view' do
            controller.params[:uin]=328
            controller.params[:first_name]=nil
            controller.params[:last_name]=nil
            controller.params[:review_year]=nil
            
            get :index
            expect(response).to render_template('searches/index')
        end
    end
end
