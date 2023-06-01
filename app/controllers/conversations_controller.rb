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
      conversation.historic = "#{@question.content}\n#{response}"
    else
      response = OpenaiService.new("#{conversation.historic}\n#{params[:entry]}").call
      conversation.historic += "\n#{@question.content}\n#{response}"
    end
    conversation.save
    @answer = Answer.create(content: response, question: @question)
    redirect_to conversation_path(conversation)
  end
end
