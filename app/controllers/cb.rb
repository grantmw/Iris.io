enable :sessions

get '/users/:u_id/tests/cb' do
  @e_message = nil
  session[:cb_tries] = nil
  erb :cb
end


post '/users/:u_id/tests/cb' do

  @e_message = "Try again. Errors with questions: "
  if params[:ten] != "10"
    @e_message += '1 '
  end
  if params[:fourtwo] != "42"
    @e_message += '2 '
  end

  if params[:onesix] != "16"
    @e_message += '3'

  end
  if params[:twonine] != "29"
    @e_message += '4 '

  end
  if params[:two] != "2"
    @e_message += '5'
  end
  if params[:five] != "5"
    @e_message += '6 '
  end
  if params[:fiveseven] != "57"
    @e_message += '7 '
  end
  if params[:six] != "6"
    @e_message += '8 '
  end
  if params[:seven] != "7"
    @e_message += '9 '
  end
  if not /\d/ === @e_message
    session[:cb_tries] = nil
    @e_message = "All Correct, Result: Negative"
    SavedTest.create(user_id: session[:id], result_cb: 'negative')
    erb :cb
  else
    if session[:cb_tries]
      session[:cb_tries] += 1
    else
      session[:cb_tries] = 1
    end
    @e_message += ". Attempts: #{session[:cb_tries]}"
    if session[:cb_tries] == 4
      SavedTest.create(user_id: session[:id], result_cb: 'positive')
      @e_message = "Test failed. Result: Positive. Try again."
      session[:cb_tries] = 0
    end
  end
  erb :cb
  # redirect '/users/#{params[:u_id]}/tests/cb'
end
