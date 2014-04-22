class TimeDeltasController < ApplicationController

  def create
    @stock = Stock.find(params[:stock_id])
    @time_delta = @stock.time_deltas.create(time_delta_params)
    redirect_to stock_path(@stock)
  end

  private        # You're now on refactoring nested classes
    def time_delta_params
      params.require(:time_delta).permit(:start, :length)
    end
end