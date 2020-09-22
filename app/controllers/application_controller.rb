require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "bakedbeans!"
  end

  get '/' do
    erb :'home'
  end

  helpers do

    def logged_in? 
      !!session[:owner_id]
    end

    def redirect_if_not_logged_in
      if !current_owner
        redirect '/login'
      end
    end

    def current_owner
      Owner.find_by(id: session[:owner_id])
    end

    def check_owner?(inst)
      inst && inst.owner == current_owner
    end

  end

end