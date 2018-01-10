defmodule Promo.Flat do
  def apply(%{total: total} = order, %{type: :flat} = promo) do
    adjustments = Map.get(order, :adjustments, [])
    new_adjustment = %{
      type: :promo,
      amount: -promo.amount,
      promo_id: promo.id,
    }

    {:ok, Map.merge(order, %{
      adjustments: [new_adjustment | adjustments],
      total: total - promo.amount
    })}
  end
end
