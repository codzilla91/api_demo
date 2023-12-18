require "test_helper"

class CurrencyConverterControllerTest < ActionDispatch::IntegrationTest
  test 'should convert currency' do
    get '/convert', params: { source: 'USD', target: 'JPY', amount: '$1,525' }
    assert_response :success

    response_data = JSON.parse(response.body)
    assert_equal 'success', response_data['msg']
    assert_equal '$170,496.53', response_data['amount']
  end
end
