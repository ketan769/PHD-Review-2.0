class SearchesController < ApplicationController
    
    def search_params
        params.require(:search).permit(:uin)
        
    end

    def new
    end

    def index
    @search=Search.where(:uin => 327005544)
    end
end
