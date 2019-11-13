class SearchesController < ApplicationController
    
   
    def search_params
        params.require(:search).permit(:uin, :first_name, :last_name, :review_year)
        # logger.debug(params.inspect)
    end
    
    
    def new
    end
    
    
    def index
            
        # @search=Search.search_func(params)
        @temp=Review.rev_func(params)
        # byebug
        # @search=@search.first.reviews
        # logger.debug(@search.inspect)  
        # if params[:uin]!=""
        #     @search = Search.where(:uin => params[:uin])
        # elsif params[:first_name]!=""
        #     @search = Search.where(:first_name => params[:first_name])
        # elsif params[:last_name]!=""
        #     @search = Search.where(:last_name => params[:last_name])
        # elsif params[:review_year]!=""
        #     @search = Search.where(:review_year=> params[:review_year])
        # else
        #     @search = Search.all
        # end
        # @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
        # logger.debug(@search.inspect)
        return @temp    
    end
end


    # def new
    #     @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    # end
