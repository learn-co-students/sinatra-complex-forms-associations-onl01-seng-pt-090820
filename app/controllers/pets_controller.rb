class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet = Pet.create(name: params[:pet_name])
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params["pet"]["owner_id"].join)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
      end
      #binding.pry
      @pet = Pet.find(params[:id])
      @pet.update(name: params["pet_name"], owner_id: params["pet"]["owner_id"].join)
      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
      end
      @pet.save
      redirect "pets/#{@pet.id}" 
  end

end