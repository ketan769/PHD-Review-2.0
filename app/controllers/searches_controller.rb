class SearchesController < ApplicationController
    
    def search_params
        params.require(:search).permit(:uin, :first_name, :last_name, :review_year)
        # logger.debug(params.inspect)
    end
    
    
    def new
    end
    
    
    def index
<<<<<<< HEAD
        logger.debug(params.inspect)    
        @search=search_func(params)
        # @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
        # logger.debug(@search.inspect)    
=======
        
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
        @searches=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'Sethi', :review_year => '2018'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'Sethi', :review_year => '2018' },
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'Sethi', :review_year => '2018'}]
>>>>>>> 7b80666b07a1f57e565e7f8acc74e30ec608b11f
    end
end


    # def new
    #     @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    # end
