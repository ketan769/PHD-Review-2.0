class ReviewsController < ApplicationController
  
    def review_params
        params.require(:review).permit(:review_score, :comments_for_student, :comments_for_student, :notes)
    end
    def index
        @reviews = Review.all
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
      flash[:notice] = "#{@review.user_id} was successfully created."
      redirect_to reviews_path
    end
    
    def edit
      @review = Review.find params[:id]
    end
    
    def update
      @review = Review.find params[:id]
      @review.update_attributes!(review_params)
      flash[:notice] = "#{@review.user_id} was successfully updated."
      redirect_to review_path(@review)
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
