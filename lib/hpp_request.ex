defmodule HppRequest do
  @moduledoc """
  Holds info for the Realex Hpp request.
  """
  defstruct(
    merchant_id: nil,
    account: nil,
    order_id: nil,
    amount: nil,
    currency: nil,
    timestamp: nil,
    sha1hash: nil,
    auto_settle_flag: nil,
    comment1: nil,
    comment2: nil,
    return_tss: nil,
    shipping_code: nil,
    shipping_co: nil,
    billing_code: nil,
    billing_co: nil,
    cust_num: nil,
    var_ref: nil,
    prod_id: nil,
    hpp_lang: nil,
    card_payment_button: nil,
    card_storage_enable: nil,
    offer_save_card: nil,
    payer_ref: nil,
    pmt_ref: nil,
    payer_exist: nil,
    validate_card_only: nil,
    dcc_enable: nil,
    hpp_fraud_filter_mode: nil,
    hpp_select_stored_card: nil
  )

  def build_hash(secret, request) do
    new_request = request
      |> generate_defaults
      |> set_payer_ref

    hash = new_request
      |> default_seed
      |> add_payer_ref_and_pmt_ref(new_request)
      |> add_fraud_filter_mode(new_request)

    %HppRequest{new_request | sha1hash: Generator.encode_hash(hash, secret)}
  end

  defp generate_defaults(%HppRequest{timestamp: timestamp, order_id: order_id} = request) do
    %HppRequest{
      request |
      timestamp: if timestamp && timestamp != "" do
        timestamp
      else
        Generator.timestamp
      end,
      order_id: if order_id && order_id != "" do
        order_id
      else
        Generator.order_id
      end
    }
  end

  defp set_payer_ref(%HppRequest{hpp_select_stored_card: hpp_select_stored_card} = request) do
    if hpp_select_stored_card && hpp_select_stored_card != "" do
      %HppRequest{request| payer_ref: hpp_select_stored_card}
    else
      request
    end
  end

  defp add_fraud_filter_mode(hash_seed, %HppRequest{hpp_fraud_filter_mode: hpp_fraud_filter_mode}) do
    if hpp_fraud_filter_mode && hpp_fraud_filter_mode != "" do
      Enum.join [hash_seed, hpp_fraud_filter_mode], "."
    else
      hash_seed
    end
  end

  defp add_payer_ref_and_pmt_ref(hash_seed, %HppRequest{card_storage_enable: "1", payer_ref: payer_ref, pmt_ref: pmt_ref}) do
    payer_and_payment = [payer_ref || "", pmt_ref || ""]
    Enum.join [hash_seed, Enum.join(payer_and_payment, ".")], "."
  end

  defp add_payer_ref_and_pmt_ref(hash_seed, %HppRequest{hpp_select_stored_card: hpp_select_stored_card, payer_ref: payer_ref, pmt_ref: pmt_ref}) do
    if !hpp_select_stored_card || hpp_select_stored_card == "" do
      hash_seed
    else
      Enum.join [hash_seed, Enum.join([payer_ref || "", pmt_ref || ""], ".")], "."
    end
  end

  defp default_seed(%HppRequest{timestamp: timestamp, merchant_id: merchant_id, order_id: order_id, amount: amount, currency: currency}) do
    [
      timestamp,
      merchant_id,
      order_id,
      amount,
      currency
    ]
    |> Enum.map(&HppEncodable.value_or_empty/1)
    |> Enum.join(".")
  end
end
