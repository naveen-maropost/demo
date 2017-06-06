class Api::V1::FeaturesController < Api::V1::ApiController
  layout false
  
  def add_image
    gallery = Gallery.new
    gallery.set_attributes(params)
    respond_to do |format|
      if gallery.persisted?
        format.json { render json:  { name: gallery.name,
                                      image_url: gallery.attachment.url,
                                      status:"Success",
                                      message: "Picture saved successfully!!!",
                                      code: 200 }.to_json
                                    }
      else
        format.json { render json: { status:"Failure", message: gallery.errors, status: 500 }.to_json}
      end
    end
  end

  def contact_us_submit
    contact_detail = ContactDetail.new(contact_details_params)
    respond_to do |format|
      if contact_detail.save
        format.json { render json:  { name: contact_detail.name,
                                      email: contact_detail.email,
                                      mobile_number: contact_detail.mobile_number,
                                      description: contact_detail.description,
                                      status:"Success",
                                      message: "Thank you for letting us know!!!",
                                      code: 200 }.to_json
                                    }
      else
        format.json { render json: { status:"Failure", message: contact_detail.errors.messages.map{|k, v| v[0]}, status: 500 }.to_json}
      end
    end
  end

  def get_image
    image = Gallery.find_by(id: params[:id])
    respond_to do |format|
      if image
        format.json { render json:  { data: {
                                      name: image.name,
                                      image_url: image.attachment.url
                                      },
                                      status:"Success",
                                      message: "Successful",
                                      code: 200 }.to_json
                                    }
      else
        format.json { render json: { status:"Failure", message: "Sorry image not found with the provided id", status: 500 }.to_json}
      end
    end
  end

  private
    def contact_details_params
      params.require(:contact_detail).permit(:name, :email, :mobile_number, :description)
    end
end