class GameController < ApplicationController
  before_action :check_origin, only: [:index]

  def index
    render :index
  end

  def play
    checker = PasswordChecker.new(params[:password])
    if checker.accepted?
      render :play
    else
      flash[:error] = "Na na na, wrong password."
      render :index
    end
  end

  private

  def check_origin
    render "errors/wrong_origin" unless request.referer && URI(request.referer).path == "/"
  end
end
