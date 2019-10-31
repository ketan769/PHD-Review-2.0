class SearchesController < ApplicationController
    
    def search_params
        params.require(:search).permit(:uin)
        
    end

    def new
        @search=[{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'},
            {:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi'}]
    end

    def index
    @search=Search.where(:uin => 327005544)
    end
end
