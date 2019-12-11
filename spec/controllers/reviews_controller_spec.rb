# require 'rails_helper'

# RSpec.describe ReviewsController, type: :controller do
#   describe 'index' do
#         let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
#         let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
#         let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}
        
#         it 'opens the review table' do
#             get :index, :params=> {:uin => 329},:session => {:user => 328}
#             expect(response).to render_template("reviews/index")
#         end
        
#         it 'Check data' do
#             get :index,  :params=> {:format => "2020/329"},:session => {:user => 328}
#             expect(assigns(:reviews)).not_to be_nil
#         end
#     end
# end
