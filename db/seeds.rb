# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
searches= [{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi',:review_year =>2018},
          {:uin =>3270101101, :first_name => 'ABC', :last_name=> 'DEF',:review_year =>2019},
          {:uin =>3270181291, :first_name => 'GHI', :last_name=> 'JKL',:review_year =>2018},
          {:uin =>3270101101, :first_name => 'MNO', :last_name=> 'PQR',:review_year =>2018},
          {:uin =>3270181291, :first_name => 'STU', :last_name=> 'VWX',:review_year =>2019}]
            
searches.each do |ser|
  Search.create!(ser)
end

auths= [{:username => 123, :password=> 'abc', :email=> 'dola16shaw@gmail.com',:role =>2018},
          {:username =>327, :password=> 'def', :email=> 'DEF',:role =>2019}]
auths.each do |ser|
Auth.create!(ser)
end