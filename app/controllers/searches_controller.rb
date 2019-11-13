class SearchesController < ApplicationController
    
    def search_params
        params.require(:search).permit(:uin, :first_name, :last_name, :review_year)
        # logger.debug(params.inspect)
    end
    
    
    def new
    end
    
    
    def index
        logger.debug(params.inspect)    
        @search=search_func(params)
        # @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
        #     {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
        # logger.debug(@search.inspect)    
    end
end


    # def new
    #     @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
    #         {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    # end
