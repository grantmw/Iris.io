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
    list = ('A'..'Z').to_a.sample(5).join.upcase
    @list = list
  if not session[:line]
    session[:line] = 1
    session[:tries] = 0
    # @font_size = 200

    erb :input

  end
  # if session[:line] == 1
  #   @list = "RDOEN"
  #   @font_size = 21.33956714
  #   erb :input
  # elsif session[:line] == 0
  #   @list = "ZAOBI"
  #   @font_size = 16.00467536
  #   erb :input
  # elsif session[:line] == 2
  #   @list = "ANIKL"
  #   @font_size = 10.66978357
  #   erb :input
  # elsif session[:line] == 3
  #   @list = "YGOPC"
  #   @font_size = 8.535826857
  #   erb :input
  # elsif session[:line] == 4
  #   @list = "XZVHE"
  #   @font_size = 6.401870143
  #   erb :input
  # elsif session[:line] == 5
  #   @list = "CTBUD"
  #   @font_size = 5.334891786
  #   erb :input
  # elsif session[:line] == 6
  #   @list = "RJAPM"
  #   @font_size = 4.267913429
  #   erb :input
  # elsif session[:line] == 7
  #   @list = "VNQBL"
  #   @font_size = 3.73442425
  #   erb :input
  # elsif session[:line] == 8
  #   @list = "LXCKL"
  #   @font_size = 3.200935071
  #   erb :input
  # elsif session[:line] == 9
  #   @list = "TDIAC"
  #   @font_size = 2.66744589282
  #   erb :input
  # elsif session[:line] == 10
  #   @list = "HEUNG"
  #   @font_size = 2.133956714256
  #   erb :input
  # elsif session[:line] == 11
  #   @list = "JOJIQ"
  #   @font_size = 1.600467536

  #   erb :input
  # elsif session[:line] == 12
  #   session[:line] = 1
  #   erb :input
  # end
  erb :input
   #strings will automatically go to the browser

end


post '/users/:u_id/tests/vision' do
  while session[:line] < 12 && session[:tries] < 4
    if params[:answer] == params[:fiveletters].downcase
      p "it set"
      session[:line] += 1
      session[:tries] = 0
      redirect "/users/#{params[:u_id]}/tests/vision"
    else
      session[:tries] += 1
      redirect "/users/#{params[:u_id]}/tests/vision"
    end
  end
    session[:tries] = 0
    redirect "/users/#{params[:u_id]}/tests/results"
end


get '/users/:u_id/tests/results' do
  unless session[:line] == 1
  @result = Vision.find(session[:line]-1).level
  session[:line] = 1
  SavedTest.create(user_id: params[:u_id], result_both: @result, test_type: 'vision')
  #make vision a wildcard --
  #restful: tests/:test_id/results - or something like that
  erb :results
  else
  @result = Vision.find(session[:line]).level
  session[:line] = 1
  SavedTest.create(user_id: params[:u_id], result_both: @result, test_type: 'vision')
  erb :results
  end
end


get '/users/:u_id/tests/colorblindness' do
  p 'hellpooooooo'
  redirect '/'
end

