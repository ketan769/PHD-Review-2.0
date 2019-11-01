class Search < ActiveRecord::Base
 def self.search_func (search)
    @searches = Search.where(:uin => search[:uin]) #OR :first_name => search[:first_name])
  end
end

