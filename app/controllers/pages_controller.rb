class PagesController < ApplicationController
  def chat
    @response = OpenaiService.new('how is it going').call
  end
end
