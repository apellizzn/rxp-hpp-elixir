ExUnit.start()

defmodule TestHelper do

  def valid_hpp_request(with_card_storage)do
    if with_card_storage do
      %HppRequest{valid_hpp_request() | card_storage_enable: "1", offer_save_card: "1"}
    else
      valid_hpp_request()
    end
  end

  def valid_hpp_request do
    %HppRequest{
      merchant_id: "MerchantID",
      account: "myAccount",
      order_id: "OrderID",
      amount: "100",
      currency: "EUR",
      timestamp: "20990101120000",
      sha1hash: "5d8f05abd618e50db4861a61cc940112786474cf",
      auto_settle_flag: "1",
      comment1: "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥",
      comment2: "Comment Two",
      return_tss: "0",
      shipping_code: "56|987",
      shipping_co: "IRELAND",
      billing_code: "123|56",
      billing_co: "IRELAND",
      cust_num: "123456",
      var_ref: "VariableRef",
      prod_id: "ProductID",
      hpp_lang: "EN",
      card_payment_button: "Submit Payment",
      card_storage_enable: "0",
      offer_save_card: "0",
      payer_ref: "PayerRef",
      pmt_ref: "PaymentRef",
      payer_exist: "0",
      validate_card_only: "0",
      dcc_enable: "0"
    }
  end
end