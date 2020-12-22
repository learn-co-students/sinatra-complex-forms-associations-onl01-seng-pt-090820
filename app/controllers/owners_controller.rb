class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all	    @owners = Owner.all
    erb :'/owners/index' 	    erb :'/owners/index'
  end	  end


  get '/owners/new' do 	  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'	    erb :'/owners/new'
  end	  end


  post '/owners' do

    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end	  end


  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])	    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'	    erb :'/owners/edit'
  end	  end


  get '/owners/:id' do 	  get '/owners/:id' do
    @owner = Owner.find(params[:id])	    @owner = Owner.find(params[:id])
    erb :'/owners/show'	    erb :'/owners/show'
  end	  end


  patch '/owners/:id' do 	  patch '/owners/:id' do

    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end	  end
end 	end

