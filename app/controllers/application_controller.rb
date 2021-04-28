require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    
    if  params[:username].empty? || params[:password].empty? 

    	 @error= "User Name and Password can't be blank"

    	 erb :'users/login'

    elsif  @user=User.find_by(username: params[:username]) 

             session[:user_id] = @user.id
             redirect '/recipes'
     else
      
     	@error ="Account not found "
     	  erb :'users/login'


  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    ##your code here
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
