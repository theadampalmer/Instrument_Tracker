class InstrumentsController < ApplicationController

  get '/instruments' do
      @instruments = Instrument.all
      erb :'instruments/index'
  end

  get '/instruments/new' do
    if logged_in?
      erb :'/instruments/new'
    else
      redirect_if_not_logged_in
    end
  end

  post '/instruments' do
    if logged_in?
      @instrument = current_owner.instruments.build(params)
      if @instrument.save
        redirect to "/instruments/#{@instrument.id}"
      else
        redirect to '/instruments/new'
      end
    end
      redirect_if_not_logged_in
  end

  get '/instruments/:id' do
    redirect_if_not_logged_in
    if @instrument = Instrument.find_by(params)
      erb :'instruments/show'
    else
      redirect '/instruments'
    end
  end

  get '/instruments/:id/edit' do
    redirect_if_not_logged_in
    @instrument = Instrument.find_by(params)
    if !check_owner(@instrument)
      redirect "/instruments"
    end
      erb :'instruments/edit'
  end

  patch '/instruments/:id' do
    redirect_if_not_logged_in
    @instrument = Instrument.find_by(id: params[:id])
    if check_owner(@instrument)
      @instrument.update(params[:instrument])
    else
      redirect to "/instruments"
    end
      erb :'instruments/show'
  end

  delete '/instruments/:id' do
    redirect_if_not_logged_in
    @instrument = Instrument.find_by(id: params[:id])
    if check_owner(@instrument)
      @instrument.delete
    end
      redirect to '/instruments'
    end

end