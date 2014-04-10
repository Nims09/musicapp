class StocksController < ApplicationController
	def new
		@stock = Stock.new
	end

	def index
		@stocks = Stock.all
	end

	def create
		# XXX Add columns for delta and current standing when we get there
		# they can intiate to nil
		@stock = Stock.new(stock_params)
		if @stock.save
			redirect_to @stock	
		else
			render 'new'
		end
	end

	def show
		@stock = find_stock
	end

	def edit
		@stock = find_stock
	end

	def update
		@stock = find_stock


		if @stock.update(stock_params)
			redirect_to @stock
		else
			render 'edit'
		end
	end

	def destroy
		@stock = find_stock
		@stock.destroy

		redirect_to stocks_path
	end


	private 
		def stock_params
			params.require(:stock).permit(:name, :hashtag)
		end

		def find_stock
			return Stock.find(params[:id])
		end
end
