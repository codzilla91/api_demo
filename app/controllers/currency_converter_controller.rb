class CurrencyConverterController < ApplicationController
  def convert
    source_currency = params[:source]
    target_currency = params[:target]
    amount = params[:amount].gsub(/[^\d.]/, '').to_f

    exchange_rate = get_exchange_rate(source_currency, target_currency)
    converted_amount = (amount * exchange_rate).round(2)

    render json: { msg: 'success', amount: format_currency(converted_amount) }
  end

  private

  def get_exchange_rate(source_currency, target_currency)
    currencies = {
      'TWD' => { 'TWD' => 1, 'JPY' => 3.669, 'USD' => 0.03281 },
      'JPY' => { 'TWD' => 0.26956, 'JPY' => 1, 'USD' => 0.00885 },
      'USD' => { 'TWD' => 30.444, 'JPY' => 111.801, 'USD' => 1 }
    }

    currencies[source_currency][target_currency]
  end

  def format_currency(amount)
    format('$%.2f', amount).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\1,')
  end
end
