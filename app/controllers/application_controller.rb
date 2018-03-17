require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
      Post.create(params)
      redirect '/posts'
  end

  get '/posts' do
    @post_list = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    Post.update( params[:id], :name => params[:name], :content => params[:content])
    redirect to("/posts/#{params[:id]}")
  end

  delete '/posts/:id/delete' do
    @id = params[:id]
    @post_name = Post.find(@id).name
    Post.delete(@id)
    erb :del
  end
end
