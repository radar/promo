defmodule Promo.BasicAdjustmentTest do
  use ExUnit.Case

  test "an order with a negative adjustment of 10" do
    order = %{
      items: [
        %{ price: 20 },
      ],
      adjustments: [
        %{ amount: -10, type: :other }
      ]
    }

    { :ok, order } = Promo.process(order)
    assert(order.total == 10)
  end

  test "an order with a positive adjustment of 10" do
    order = %{
      items: [
        %{ price: 20 },
      ],
      adjustments: [
        %{ amount: 10, type: :other }
      ]
    }

    { :ok, order } = Promo.process(order)
    assert(order.total == 30)
  end
end
