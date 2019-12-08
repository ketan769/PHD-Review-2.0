class ReviewsController < ApplicationController
  
    def review_params
        params.require(:review).permit(:user,:review_year,:review_score, :comments_for_student, :comments_for_faculty, :notes)
    end
    def index
        if params[:format]==nil or params[:format]==""
          params[:format]=session[:format]
        end
        temp=params[:format].match(/(\w+)(\/)(\w+)/)
        session[:format]=params[:format]
        @reviews = Review.rev_func(temp[3]).where(:year =>temp[1])
        
    end
    
    def new
        @review = Review.new
    end
    
    def show
      id = params[:id] # retrieve review ID from URI route
      @review = Review.find(id) # look up review by ID
    end
    
    def create
      @review = Review.create!(review_params)
      flash[:notice] = "review was successfully updated."
      redirect_to '/reviews' and return
    end
    
    def edit
      @review = Review.find params[:id]
    end
    
    def update
      byebug
      @review = Review.find params[:id]
      @review.update_attributes!(review_params)
      temp3=User.where(:uin => session[:user]).pluck(:first_name)
      temp4=User.where(:uin => session[:user]).pluck(:last_name)
      if temp3!=[] and temp4!=[]
        temp5=temp3[0]+' '+temp4[0]
      else 
        temp5=""
      end  
      @review.update_attributes!(:reviewer => temp5)
      flash[:notice] = "review was updated successfully updated."
      redirect_to '/reviews' and return
    end
    
    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      flash[:notice] = "Review '#{@review.user_id}' deleted."
      redirect_to reviews_path
    end
      
    def set_user
      @user = User.find(params[:uin])
    end
end
