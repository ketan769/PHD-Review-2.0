class ReviewsController < ApplicationController
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
      flash[:notice] = "#{@review.name} was successfully created."
      redirect_to reviews_path
    end
    
    def edit
      @review = Review.find params[:id]
    end
    
    def update
      @review = Review.find params[:id]
      @review.update_attributes!(review_params)
      flash[:notice] = "#{@review.name} was successfully updated."
      redirect_to review_path(@review)
    end
    
    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      flash[:notice] = "Review '#{@review.name}' deleted."
      redirect_to reviews_path
    end
      
end
