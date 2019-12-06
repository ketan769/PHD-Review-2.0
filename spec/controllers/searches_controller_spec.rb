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
            expect(response).to redirect_to(studet_path("S",:uin =>session[:user]))
        end
    end
    describe 'index' do
        let!(:auths){Auth.create!(:username =>328,:role => "A",:password =>'k')}
        let!(:users){User.create!(:uin => 328)}
        let!(:reviews){Review.create!(:user_id => 328 ,:year => 2020)}
        
        it 'redirects to index view' do
            get :index , :params => {:uin => 328,:review_year => ""}
            expect(response).to render_template('searches/index')
        end
        it 'redirects to index view' do
            get :index , :params => {:uin => "",:review_year => 2020}
            expect(response).to render_template('searches/index')
        end
        it 'returns error on for id not existing' do
            get :index , :params => {:uin => 329,:review_year => ""}
            expect(flash[:notice]).to match("No record found")
        end
        it 'redirects to index view on searching uin ' do
            get :index , :params => {:uin => 329,:review_year => ""}
            expect(response).to render_template('searches/new')
        end
        it 'redirects to index on searching year' do
            get :index , :session => {:uin => "",:review_year => 2020}
            expect(response).to render_template('searches/index')
        end
        it 'wrong combination of year and uin gives error' do
            get :index , :session => {:uin => 329,:review_year => 2020}
             expect(flash[:notice]).to match("No record found")
        end
        it 'wrong combination of year and uin renders back the search' do
            get :index , :session => {:uin => 329,:review_year => 2020}
             expect(response).to render_template('searches/new')
        end
    end
     describe 'index' do
        let!(:auths){Auth.create!([{:username =>328,:role => "F",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => ""},{:uin =>329, :advisor => ""}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'No user with the faculty returns error' do
            get :index , :params => {:uin => 329,:review_year => 2020},:session => {:user => 328}
            expect(response).to render_template('searches/new')
        end
    end
    describe 'index' do
        let!(:auths){Auth.create!([{:username =>328,:role => "F",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => ""},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'filters based on advisor' do
            get :index , :params => {:uin => 329,:review_year => 2020},:session => {:user => 328}
            expect(response).to render_template('searches/index')
        end
          it 'filters based on advisor' do
            get :index , :params => {:uin => 329,:review_year => 2020},:session => {:user => 328}
            # expect(response).to render_template('searches/index')
            expect(assigns(:temp)).not_to be_nil         
          end
    end
    describe 'show' do
        let!(:auths){Auth.create!([{:username =>328,:role => "F",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => ""},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'Renders show page if success' do
            rev=Review.find_by(:user_id => 328)
            get :show, :id => rev.id 
            expect(response).to render_template('searches/show')
        end
    end
    describe 'date' do
        let!(:auths){Auth.create!([{:username =>328,:role => "F",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => ""},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'Renders date page' do
            get :date, :params => {:chk =>["off","on","off"]}
            expect(response).to render_template('searches/date')
        end
        it 'Finding out the selected check box' do
            get :date, :params => {:chk =>["off","on","off"]}
            expect(assigns(:temp2)).to eq(["on","off"])
        end
    end
    describe 'add_user' do
        let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'Renders add_user page' do
            get :add_user
            expect(response).to render_template('searches/add_user')
        end
        it 'check the drop down vals' do
            get :add_user 
            temp=Auth.where(:role =>"Faculty").pluck(:username)
            expect(assigns(:temp21)).to eq(['No Selection' ,'k s'])
        end
    end
    describe 'user_create' do
        let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'sad path error' do
            get :user_create, :params=> {:uin => ""}
            expect(response).to render_template('searches/add_user')
        end
        it 'sad path error password mismatch' do
            get :user_create, :params=> {:password => "k" , :c_password => 's'}
            expect(response).to render_template('searches/add_user')
        end
        it 'sad path error user already present' do
            get :user_create, :params=> {:uin => 328, :first_name =>'k', :last_name =>'s', :review_year =>2019, :email=>'k', :password => "s" , :c_password => 's'}
            expect(flash[:notice]).to match("User Already Exists")
        end
        
        it 'check creation' do
            get :user_create, :params=> {:uin =>400, :first_name =>'k', :last_name =>'s', :review_year =>2019, :email=>'k', :password => "s" , :c_password => 's',:advisor => 'k s'}
            temp=User.find_by(:uin => 400)
            expect(temp).not_to be_nil
        end
         it 'check creation' do
            get :user_create, :params=> {:uin =>400, :first_name =>'k', :last_name =>'s', :review_year =>2019, :email=>'k', :password => "s" , :c_password => 's',:advisor => 'k s'}
            expect(response).to render_template('searches/new')
        end
    end
    describe 'studet' do
        let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'Student details' do
            get :studet, :params=> {:uin => "329"}
            expect(response).to render_template('searches/studet')
        end
    end
    describe 'add_item' do
        let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        it 'renders the add item screen' do
            get :add_item 
            expect(response).to render_template('searches/add_item')
        end
    end
     describe 'item_create' do
        let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
        let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
        let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}

        # it 'adds an item to the screen' do
        #     get :item_create, :params=> {:uin => "329",:year =>2022}
        #     expect(flash[:notice]).to match("Line Item Added")
        # end
        it 'adds an item to the screen and in reviews table' do
            get :item_create, :params=> {:uin => 329,:review_year =>2022}
            temp=Review.find_by(:user_id =>329 ,:year =>2022)
            expect(temp).not_to be_nil
        end
        
    end

end
