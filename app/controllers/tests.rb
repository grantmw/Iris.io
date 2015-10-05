enable :sessions

get '/users/:u_id/tests' do
  # list of all tests, page after you log in
  if session[:id] == params[:u_id].to_i
    @user = User.find(params[:u_id])
    erb :test_list
  else
    redirect '/'
  end
end

get '/users/:u_id/tests/vision' do
  @level = 2080
  @list = "R     D     O     E     N"
   #strings will automatically go to the browser

  erb :input

end

get '/2060' do
  @level = 2060
  @list = "PYUNI"

  erb :input
end

get '/users/:u_id/tests/colorblindness' do
  p 'hello'
end
