class PagesController < ApplicationController
  def chat
    if params[:entry]
      @response = OpenaiService.new(params[:entry]).call
    else
      @response = "Ask a question"
    end
  end
end
