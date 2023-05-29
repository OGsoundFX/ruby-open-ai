class ConversationsController < ApplicationController
  def create
    @convo = Conversation.create
    redirect_to conversation_path(@convo)
  end

  def show
    @convo = Conversation.find(params[:id])
  end

  def ask_question
    @question = Question.new(content: params[:entry])
    conversation = Conversation.find(params[:conversation])
    @question.conversation = conversation
    @question.save
    if conversation.historic.nil?
      response = OpenaiService.new(params[:entry]).call 
      conversation.historic = "Q: #{@question.content}\nA: #{response}"
    else
      response = OpenaiService.new("#{conversation.historic}\nQ: #{params[:entry]}").call
      conversation.historic += "\nQ: #{@question.content}\nA: #{response}"
    end
    conversation.save
    @answer = Answer.create(content: response, question: @question)
    redirect_to conversation_path(conversation)
  end
end
