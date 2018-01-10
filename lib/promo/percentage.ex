defmodule Promo.Percentage do
  def apply(%{total: total} = order, %{type: :percentage} = promo) do
    adjustments = Map.get(order, :adjustments, [])
    amount = -(total * (promo.amount / 100))
    new_adjustment = %{
      type: :promo,
      amount: amount,
      promo_id: promo.id,
    }

    {:ok, Map.merge(order, %{
      adjustments: [new_adjustment | adjustments],
      total: total + amount
    })}
  end
end
