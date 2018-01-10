defmodule Promo do
  alias Promo.Adjustment
  alias Promo.Item

  @moduledoc """
  Documentation for Promo.
  """

  @doc """
  """

  def apply(order, %{type: :flat} = promo) do
    {:ok, order } = process(order)
    Promo.Flat.apply(order, promo)
  end

  def apply(order, %{type: :percentage} = promo) do
    {:ok, order } = process(order)
    Promo.Percentage.apply(order, promo)
  end

  def process(%{adjustments: adjustments, items: items} = order) do
    total = items |> item_total
    total = total + (adjustments |> adjustment_total)
    {:ok, order |> Map.put(:total, total)}
  end

  def process(%{items: items} = order) when is_list(items) do
    total = items |> item_total
    {:ok, order |> Map.put(:total, total)}
  end

  def process(%{items: _items}), do: {:error, "items must be specified as a list"}
  def process(%{}), do: {:error, "order must have an items key"}

  defp item_total(items) do
    items |> Item.sum
  end

  defp adjustment_total(adjustments) do
    adjustments |> Adjustment.sum
  end

end
