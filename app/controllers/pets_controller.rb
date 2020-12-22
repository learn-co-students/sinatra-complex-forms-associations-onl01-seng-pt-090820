class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all	    @pets = Pet.all
    erb :'/pets/index' 	    erb :'/pets/index'
  end	  end


  get '/pets/new' do 	  get '/pets/new' do
    erb :'/pets/new'	    erb :'/pets/new'
  end	  end


  post '/pets' do 	  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save


    redirect to "pets/#{@pet.id}"	    redirect to "pets/#{@pet.id}"
  end	  end


  get '/pets/:id' do 	  get '/pets/:id' do
    @pet = Pet.find(params[:id])	    @pet = Pet.find(params[:id])
    erb :'/pets/show'	    erb :'/pets/show'
  end	  end


  patch '/pets/:id' do 	  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save


    redirect to "pets/#{@pet.id}"
  end
end