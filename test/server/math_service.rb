require "sinatra"
require "rubygems"


get "/add_two_numbers/:num1/:num2" do
   begin
   sum = Integer("#{params[:num1]}") + Integer("#{params[:num2]}")
   "#{sum}"
   rescue
   "Invalid arguments"
   end

end