class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    new_r = Recipe.create(params)
    redirect "/recipes/#{new_r.id}"
  end


  get '/recipes/:id' do
    if Recipe.find(params[:id]) 
    @recipe = Recipe.find(params[:id])
    erb :summury
    else
      redirect '/recipes'
    end
  end
  

  delete '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect '/recipes'
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id]) 
    erb :edit
  end

  patch '/recipes/:id' do #
    @recipe = Recipe.find(params[:id])
    @recipe.cook_time = params[:cook_time]
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end 


end
