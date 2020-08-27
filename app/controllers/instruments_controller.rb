class InstrumentsController < ApplicationController

  get '/instruments' do
    if !logged_in?
      redirect '/login'
    else
      @instrument = Instrument.all
      erb :"instruments/instrument"
    end
  end

  get '/instruments/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"instruments/new"
    end
  end

  get '/instruments/:id' do
    if logged_in?
      @instrument = Instrument.find(params[:id])
      erb :'instruments/show_instrument'
    else
      redirect to '/login'
    end
  end

  get '/instruments/:id/edit' do
    if logged_in?
      @instrument = Instrument.find(params[:id])
      erb :'instruments/edit_instrument'
    else
      redirect "/login"
    end
  end

  patch '/instruments/:id/edit' do
    if logged_in?
      @instrument = Instrument.find_by(params[:id])
      if !params[:description] == ""
        redirect to "/instruments/#{@instrument.id}/edit"
      else
        @instrument.description = params[:description]
        @instrument.save
      end
    else
      redirect '/login'
    end
  end

  post '/instruments' do
    if logged_in?
      if params[:description] == ""
        redirect to 'instruments/new'
      else
        @instrument = current_owner.instruments.build(description: params[:description])
        @instrument.save
        if @instrument.save
          redirect to "/instruments/#{@instrument.id}"
        else
          redirect '/instruments/new'
        end
      end
    else
      redirect "/login"
    end
  end

  delete '/instruments/:id/delete' do
    if logged_in?
      @instrument = Instrument.find_by_id(params[:id])
      if @instrument.user_id == current_owner.id
        @instrument.delete
        redirect to '/instruments'
      else
        redirect to '/login'
      end
    end
  end

end