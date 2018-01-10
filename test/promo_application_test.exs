defmodule Promo.PromoApplicationTest do
  use ExUnit.Case

  test "applying a flat promotion" do
    order = %{
      items: [
        %{ price: 20 },
      ],
      adjustments: [
        %{ amount: 10, type: :other }
      ],
      promo_code: "10OFF"
    }

    promo = %{
      id: 1,
      code: "10OFF",
      amount: 10,
      type: :flat
    }

    { :ok, %{total: total} } = Promo.apply(order, promo)
    assert total == 20
  end

  test "applying a percentage-based promotion" do
    order = %{
      items: [
        %{ price: 20 },
      ],
      adjustments: [
        %{ amount: 10, type: :other }
      ],
      promo_code: "10%OFF"
    }

    promo = %{
      id: 1,
      code: "10%OFF",
      amount: 10,
      type: :percentage
    }

    { :ok, %{total: total} } = Promo.apply(order, promo)
    assert total == 27
  end
end
