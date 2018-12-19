class PromisesController < ApplicationController
  def index
    @promises = Promise.order(:promise_start_date)
    @abandoned = Promise.where(status: 'abandoned').count
    @in_progress = Promise.where(status: 'in progress').count
    @done = Promise.where(status: 'done').count
  end

  def show
    @promise = Promise.find(params[:id])
  end

  def new
    @promise = Promise.new
  end

  def create
    promise = Promise.new(promise_params)
    promise.status = 0
    promise.save

    redirect_to promise_path(promise)
  end

  def edit
    @promise = Promise.find(params[:id])
  end

  def update
    promise = Promise.find(params[:id])
    promise.update(promise_params)
    promise.save

    redirect_to promise_path(promise)
  end

  def destroy
    promise = Promise.find(params[:id])
    promise.destroy

    redirect_to promises_path
  end

  private

  def promise_params
    params.require(:promise).permit(:promisee, :body, :promise_start_date, :promise_end_date)
  end
end
