class GalleriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_gallery_collection, only: [:index, :destroy]

  def new
  	@gallery = Gallery.new
  end

  def create
  	@gallery = Gallery.new(gallery_params)
  	if @gallery.save
      flash[:success] = 'Picture saved successfully!!!'
      redirect_to galleries_path
    else
      render :new
    end
  end

  def show
    @gallery = Gallery.find_by(id: params[:id])
  end

  def edit
    @gallery = Gallery.find_by(id: params[:id])
  end

  def update
    gallery = Gallery.find_by(id: params[:id])
    if gallery.update(gallery_params)
      flash[:success] = 'Picture Updated Successfully!!!'
      redirect_to galleries_path
    else
      render :edit
    end
  end

  def validate_img_name
    @name = Gallery.where(name: params[:name]).first
  end

  def destroy
    gallery = Gallery.find_by(id: params[:id])
    gallery.destroy if gallery
  end

  def get_gallery_collection
    @galleries = Gallery.all.order('created_at DESC').page(params[:page]).per(6)
  end

  def get_image_count
    @count = Gallery.count
    respond_to do |format|
       format.json { render json: @count }
     end
  end

  def import
    begin
      @resp = Gallery.import(params[:file])
      binding.pry
      flash[:success] = 'Gallery imported successfully.!'
      redirect_to galleries_path
    rescue
      binding.pry
      flash[:error] = 'Something wrong with CSV file'
      redirect_to galleries_path
    end
  end

  

  private
  def gallery_params
  	params.require(:gallery).permit(:name, :attachment)
  end


end
