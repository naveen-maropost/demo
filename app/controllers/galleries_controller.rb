class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.all.page(params[:page]).per(6)
  end

  def new
  	@gallery = Gallery.new
  end

  def create
  	@gallery = Gallery.new(gallery_params)
  	if @gallery.save
      redirect_to galleries_path, notice: 'Picture saved successfully!!!'
    else
      render action: 'new'
    end
  end

  def edit
    @gallery = Gallery.find_by(id: params[:id])
  end

  def update
    @gallery = Gallery.find_by(id: params[:id])
    if @gallery.update(gallery_params)
      redirect_to galleries_path, notice: 'Picture Updated Successfully!!!'
    else
      render action: 'edit'
    end
  end

  def validate_img_name
    @name = Gallery.where("name LIKE ?", "%#{params[:name]}%")
  end

  

  private
  def gallery_params
  	params.require(:gallery).permit(:name, :attachment)
  end


end
