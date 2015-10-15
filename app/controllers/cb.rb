get '/users/:u_id/tests/cb' do
  @e_message = nil
  erb :cb
end


post '/users/:u_id/tests/cb' do

  @e_message = "Errors with questions: "
  if params[:ten] != "10"
    @e_message += '1 '
  end
  if params[:fourtwo] != "42"
    @e_message += '2 '
  end

  if params[:two] != "2"
    @e_message += '3 '

  end
  if params[:twonine] != "29"
    @e_message += '4 '

  end
  if params[:onesix] != "16"
    @e_message += '5 '
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
    @e_message = "All Correct"
  end

  erb :cb
  # redirect '/users/#{params[:u_id]}/tests/cb'
end
