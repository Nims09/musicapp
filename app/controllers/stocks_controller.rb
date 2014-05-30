class StocksController < ApplicationController

	def new
		@stock = current_user.stocks.build
	end

	def index
		if current_user
     @stocks = current_user.stocks
    else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
	end

	def create
		# XXX Add columns for delta and current standing when we get there
		# they can intiate to nil
		@stock = Stock.new(stock_params)
		if @stock.save
			redirect_to @stock, notice: 'Stock was successfully created.'	
		else
			render 'new'
		end
	end

	def show
		@stock = find_stock
		@time_delta = @stock.time_deltas.build
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
			params.require(:stock).permit(:name, :hashtag, :user_id)
		end

		def find_stock
      return Stock.find(params[:id])
  	end
end
