class TimeDeltasController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "sec", only: :destroy


  def create
    @stock = Stock.find(params[:stock_id])
    @time_delta = @stock.time_deltas.create(time_delta_params)
    redirect_to stock_path(@stock)
  end

  def destroy
    @stock = Stock.find(params[:stock_id]) 
    @time_delta = @stock.time_deltas.find(params[:id])

    # @time_delta = @stock.time_deltas.create(time_delta_params)
    @time_delta.destroy
    redirect_to stock_path(@stock)
  end

  private 
    def time_delta_params
      params.require(:time_delta).permit(:start, :length)
    end
end