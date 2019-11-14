class SearchesController < ApplicationController
    
    def search_params
        params.require(:user).permit(:uin, :first_name, :last_name, :review_year)
    end
    
    def new
    end
    def index
        if params[:uin]!=""
            @temp=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
            
        return @temp
        end
        logger.debug(params.inspect)
        if params[:first_name]!=""
            temp=User.where(:first_name =>params[:first_name]).pluck(:uin)
            @temp=Review.rev_func(temp).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        return @temp
        end
        if params[:last_name]!=""
            temp=User.where(:last_name =>params[:last_name]).pluck(:uin)
            @temp=Review.rev_func(temp).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        return @temp
        end
        temp=User.pluck(:uin)
        @temp=Review.rev_func(temp).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        return @temp
    end

    def show
      @detail=Review.rev_func(params[:uin]).where(:year => params[:review_year]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
    end
end

