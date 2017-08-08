class PostController < ApplicationController
  def new
  end

  def create
    newPost = Post.new
    newPost.title = params[:title]
    newPost.content = params[:content]
    newPost.user = current_user
    newPost.save
    
    # newPost = Post.create(title: params[:title], content: params[:content])
    
    # redirect_to '/'
    redirect_to "/show/#{newPost.id}"
  end

  def destroy
    destroyPost = Post.find(params[:id])
    destroyPost.destroy
    
    redirect_to '/'
  end

  def index
    @listPost = Post.all
  end

  def show
    @showPost = Post.find(params[:id])
  end

  def edit
    @editPost = Post.find(params[:id])
  end

  def update
    updatePost = Post.find(params[:id])
    updatePost.title = params[:title]
    updatePost.content = params[:content]
    updatePost.save
    
    # updatePost.update(title: params[:title], content: params[:content])
    
    # redirect_to '/'
    redirect_to "/show/#{updatePost.id}"
  end
end
