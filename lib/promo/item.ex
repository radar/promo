defmodule Promo.Item do
  def sum(items) do
    sum(items, 0)
  end

  defp sum([item | items], total) do
    sum(items, total + item.price)
  end

  defp sum([], total), do: total
end
