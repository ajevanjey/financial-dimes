class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[show edit update destroy]

  # GET /stocks
  def index
    @stocks = current_user.stocks.order(created_at: :desc)
  end

  # GET /stocks/:id
  def show
  end

  # GET /stocks/new
  def new
    @stock = current_user.stocks.new
  end

  # POST /stocks
  def create
    @stock = current_user.stocks.new(stock_params)
    if @stock.save
      redirect_to stocks_path, notice: "#{@stock.ticker.upcase} added to your watchlist."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /stocks/:id/edit
  def edit
  end

  # PATCH/PUT /stocks/:id
  def update
    if @stock.update(stock_params)
      redirect_to stocks_path, notice: "#{@stock.ticker.upcase} updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/:id
  def destroy
    @stock.destroy
    redirect_to stocks_path, notice: "#{@stock.ticker.upcase} removed from your watchlist."
  end

  private

  def set_stock
    @stock = current_user.stocks.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:ticker, :company_name, :notes, :target_price)
  end
end
