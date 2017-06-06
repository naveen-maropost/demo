class DashboardsController < ApplicationController
	before_action :authenticate_user!

  def index
  end

  def contact_us
  	@contact_detail = ContactDetail.new
  end

  def submit_contact
  	@contact_detail = ContactDetail.new(contact_details_params)
  	if @contact_detail.save
      flash[:success] = 'Thank you for letting us know!!!'
      redirect_to root_path
    else
      render :contact_us
    end
  end

  private
  def contact_details_params
  	params.require(:contact_detail).permit(:name, :email, :mobile_number, :description)
  end
end
