# app/services/openai_service.rb
require "openai"

class OpenaiService
  attr_reader :client, :prompt 

  def initialize(prompt)
    @client = OpenAI::Client.new
    @prompt = prompt
  end

  def call
    response = client.chat(
      parameters: {
          model: "gpt-4", # Required.
          messages: [{ role: "user", content: prompt }], # Required.
          temperature: 0.7,
          stream: false,
					max_tokens: 100 # might want to check this
      })
    # you might want to inspect the response and see what the api is giving you
    return response["choices"][0]["message"]["content"]
  end

  def generate_image
    response = client.images.generate(parameters: { prompt: prompt, size: "256x256", n: 4 }) # multiple images with the "n: 4" option
    # return response.dig("data", 0, "url") # single result
    return response.dig("data").map { |url| url["url"]} # multiple images
  end
end