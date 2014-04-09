class StocksController < ApplicationController
	def new
		# XXX Add columns for delta and current standing when we get there
		# they can intiate to nil
		@stock = Stock.new(params[:stock])
		@stock.save
		redirect_to @stock
	end

	def create
		render text: params[:stock].inspect
	end

	def show
		@stock = Stock.find(params[:id])
	end

	private 
		def post_params
			params.require(:stock).permit(:name, :hashtag)
		end
end
