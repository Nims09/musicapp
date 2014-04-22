class DeltasController < ApplicationController

  def new
    @stock = Stock.find(params[:stock_id])
    @time_delta = @stock.time_deltas.build
    respond_with(@stock, @time_delta)
  end
  def create
    @stock = Stock.find(params[:stock_id])
    @time_delta = @stock.time_deltas.build(params[:stock])
    @time_delta.save
  end

end

	private
		def delta_params
			params.require(:delta).permit(:start, :length)
		end

		def find_stock
      return Stock.find(params[:stock_id])
  	end
end
