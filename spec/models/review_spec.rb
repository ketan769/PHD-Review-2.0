# require 'rails_helper'

# RSpec.describe Review, type: :model do
#     describe 'Model test'do
#         let!(:auths){Auth.create!([{:username =>328,:role => "Faculty",:password =>'k'},{:username =>329,:role => "S",:password =>'k'}])}
#         let!(:users){User.create!([{:uin =>328, :advisor => "",:first_name =>'k' ,:last_name => 's'},{:uin =>329, :advisor => "328"}])}
#         let!(:reviews){Review.create!([{:user_id =>328 ,:year =>2020},{:user_id =>329 ,:year =>2020}])}
    
#         it 'Auth' do
#             a=Auth.create!({:username =>331,:role => "S",:password =>'k'})       
#             a.should be_valid
#         end
#         it 'review' do
#             a=Review.create!({:user_id =>329,:year =>2022})       
#             a.should be_valid
#         end
#         it 'review' do
#             a=Review.rev_func({:user_id =>329})       
#             expect(a).not_to be_nil
#         end
#     end    
        
# end
