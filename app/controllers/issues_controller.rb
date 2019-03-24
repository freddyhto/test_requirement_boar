class IssuesController < ApplicationController
  before_filter :set_issue, :except => [:index, :create]
  respond_to :json

  def index
    render json: Issue.issues_and_votes
  end

  def new
    respond_with Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  def update
    @issue.update_attributes!(issue_params)
    render json: @issue
  end

  def show
    render json: Issue.find(params[:id])
  end

  def score
    if @issue.add_vote(params[:vote], current_user.id)
      render json: @issue
    end
  end

  private
    def set_issue
      @issue = Issue.find params[:id]
    end

    def issue_params
      params.require(:issue).permit(:title, :description)
    end

end