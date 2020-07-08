class AuthorApiController < ApplicationController
	# before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
    render json: @authors
    return
  end

  # # GET /authors/1
  # # GET /authors/1.json
  def show
  	@author = Author.find(params[:id].to_i)
    response = { :author =>  @author , :author_books =>  @author.books  }
      respond_to do |format|
        format.json  { render :json => response }
      end
  
  end

end
