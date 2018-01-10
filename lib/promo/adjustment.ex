defmodule Promo.Adjustment do
  def sum(adjustments) do
    sum(adjustments, 0)
  end

  defp sum([adjustment | adjustments], total) do
    sum(adjustments, total + adjustment.amount)
  end

  defp sum([], total), do: total
end
