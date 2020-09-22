class OwnersController < ApplicationController

    get "/signup" do
      if current_owner
        redirect '/instruments'
      end
        erb :'owners/signup'
    end
#check to make sure username isnt already in db
    post "/owners" do
      owner = Owner.create(params)
      if owner.valid?
        session[:owner_id] = owner.id
        redirect "owners/#{owner.username}"
      else
        redirect '/signup'
      end
    end
   
    get "/owners/:username" do
      @owner = Owner.find_by(params)
      if @owner == nil
        redirect '/'
      end
      erb :'owners/show'
    end

    get "/login" do
      if current_owner
      end
      erb :'owners/login'
    end
    
    post "/login" do
      owner = Owner.find_by(username: params[:username])
      if owner && owner.authenticate(params[:password])
        session[:user_id] = owner.id
        redirect "owners/#{owner.username}" 
      else
        redirect '/error'
      end
    end

    get "/error" do
      erb :'owners/error'
    end

    get '/logout' do
      session.clear
      redirect '/'
    end

end
 