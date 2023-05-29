class PagesController < ApplicationController
  def chat
    if params[:entry]
      @response = OpenaiService.new(params[:entry]).call
    else
      @response = "Ask a question"
    end
    
    if params[:image_entry]
      @image_response = OpenaiService.new(params[:image_entry]).generate_image
      @intro = ""
    else
      @intro = "search an image"
    end
  end
end
