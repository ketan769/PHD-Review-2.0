class SearchesController < ApplicationController
    
   
    def search_params
        params.require(:search).permit(:uin, :first_name, :last_name, :review_year)
        # debug_inspector(params)
    end
    
    
    def new
    end
    
    
    def index
        
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
        @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
        logger.debug(@search.inspect)    
    end
end


    # def new
    #     @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    # end
