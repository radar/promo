defmodule Promo.PercentageTest do
  use ExUnit.Case
  alias Promo.Percentage

  test "applies a 10% off promo" do
    order = %{
      items: [
        %{ price: 20 },
      ],
      adjustments: [
        %{ amount: 10, type: :other }
      ],
      total: 30,
      promo_code: "10OFF"
    }

    promo = %{
      id: 1,
      code: "10OFF",
      amount: 10,
      type: :percentage
    }

    { :ok, %{total: total, adjustments: adjustments}} = Percentage.apply(order, promo)
    assert total == 27

    other_adjustment = Enum.find(adjustments, fn (adjustment) ->
      adjustment.type == :other
    end)
    assert other_adjustment.amount == 10

    promo_adjustment = Enum.find(adjustments, fn (adjustment) ->
      adjustment.type == :promo
    end)

    assert promo_adjustment.amount == -3
    assert promo_adjustment.promo_id == promo.id
  end
end
