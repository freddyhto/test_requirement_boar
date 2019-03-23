class IssuesController < ApplicationController

  respond_to :json

  def index
    render json: Issue.all
  end

  def new
    respond_with Issue.new
  end

  def create
    respond_with Issue.create(params[:issue])
  end

  def update
    respond_with Issue.update(params[:id], params[:issue])
  end

  def show
    respond_with Issue.find(params[:id])
  end

  def score
    respond_with Issue.update_score(params[:id], params[:vote])
  end

  private
    def issue_params
      params.require(:issue).permit(:title, :description)
    end

end