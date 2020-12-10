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
    if params[:pet][:name].empty?
      redirect '/pets/new'
    end
    if params[:pet][:owner_id].nil? && params[:owner][:name].empty?
      redirect '/pets/new'
    elsif params[:pet][:owner_id].nil? && !params[:owner][:name].empty?
      @pet = Pet.create(name: params[:pet][:name])
      @pet.owner = Owner.create(params[:owner])
      @pet.save
      redirect to "pets/#{@pet.id}"
    elsif !params[:pet][:owner_id].empty? && !!params[:owner][:name].empty?
      @pet = Pet.create(params[:pet])
      redirect to "pets/#{@pet.id}"
    else
      redirect '/pets/new'
    end
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    
    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    # binding.pry
    if params[:owner][:id] && params[:owner][:name].empty?
      @pet.update(name: params[:pet][:name], owner_id: params[:owner][:id])
    elsif !params[:owner][:name].empty?
      @pet.update(params[:pet])
      new_owner = Owner.create(name: params[:owner][:name])
      @pet.owner = new_owner
      @pet.save
    else
      redirect '/pets/:id'
    end 
    redirect to "pets/#{@pet.id}"
  end
end