defmodule Helper do
  @moduledoc """
  Helper methods
  """
  @doc """
  `read_as` read json and returns a struct

  ## Examples

      iex> Helper.read_as ~s({"merchant_id": "test-merch"}), %HppRequest{}
      %HppRequest{merchant_id: "test-merch"}
  """
  def read_as(json, encodable) do
    Poison.decode! json, as: encodable
  end

  @doc """
  `keys` return all the keys from the given struct

  ## Examples

      iex> Helper.keys %HppRequest{merchant_id: "test-merch"}
      [:account, :amount, :auto_settle_flag, :billing_co, :billing_code,
        :card_payment_button, :card_storage_enable, :comment1, :comment2, :currency,
        :cust_num, :dcc_enable, :hpp_fraud_filter_mode, :hpp_lang,
        :hpp_select_stored_card, :merchant_id, :offer_save_card, :order_id,
        :payer_exist, :payer_ref, :pmt_ref, :prod_id, :return_tss, :sha1hash,
        :shipping_co, :shipping_code, :timestamp, :validate_card_only, :var_ref]
  """
  def keys(encodable) do
    Map.keys(encodable) -- [:__struct__]
  end
  @doc """
  Covert a lower case atom to upper case

  ## Examples

      iex> Helper.upcase_atom :test
      :TEST

  """
  def upcase_atom(field) do
    map_atom field, &String.upcase/1
  end

  @doc """
  Covert a upper case atom to lower case

  ## Examples

      iex> Helper.downcase_atom :TEST
      :test

  """
  def downcase_atom(field) do
    map_atom field, &String.downcase/1
  end

  @doc """
  Returns value if not nil empty string otherwise

  ## Examples

      iex> Helper.value_or_empty "test"
      "test"

      iex> Helper.value_or_empty nil
      ""

  """
  def value_or_empty(value) do
    value || ""
  end

  defp map_atom(field, func) do
    field
    |> Atom.to_string
    |> func.()
    |> String.to_atom
  end
end
