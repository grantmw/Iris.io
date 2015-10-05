enable :sessions

get '/' do
  if session[:id]
    redirect "/users/#{session[:id]}/tests"
  else
    erb :homepage
  end
end

get '/users/new' do
  erb :registration
end

post '/users' do
  #post for registration
  User.create(name: params[:name],age: params[:age], email: params[:email], password: params[:password])
  redirect '/'
end


post '/users/authenticate' do
  #post for login
  #check password - using bcrypt
  @user = User.find_by(email: params[:email])
  if @user.password == params[:password]
    session[:id] = @user.id
    redirect "/users/#{@user.id}/tests"
  else
    redirect '/'
  end
end

get '/users/logout' do
  session.delete('id')
  redirect '/'
end

