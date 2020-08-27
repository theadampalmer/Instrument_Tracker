class OwnersController < ApplicationController

    get '/signup' do
      if !logged_in?
        erb :signup
      else
        redirect '/instruments'
      end
    end

   post '/signup' do
     if params[:username] == "" || params[:email] == "" || params[:password] == ""
       redirect '/signup'
     else
       @owner = Owner.create(username: params[:username], email: params[:email], password: params[:password])
       session[:user_id] = @owner.id
       redirect '/instruments'
     end
   end
   
    get '/login' do
      if !logged_in?
        erb :'owners/login'
      else
        redirect '/instruments'
      end
    end
    
    post '/login' do
      @owner = Owner.find_by(:username => params[:username])
      # binding.pry
    if @owner && @owner.authenticate(params[:password])
      session[:user_id] = @owner.id
      redirect '/instruments'
    else
      redirect '/signup'
    end
  end

   get "/owners/:slug" do
    # binding.pry
    @owner = Owner.find_by_slug(params[:slug])
    erb :'owners/show'
    end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
 