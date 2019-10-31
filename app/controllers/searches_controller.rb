class SearchesController < ApplicationController
    
    def search_params
        params.require(:search).permit(:uin)
        # debug_inspector(params)
    end
    
    
    def new
    end
    
    
    def index
        @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    end
end
