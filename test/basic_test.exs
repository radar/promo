defmodule Promo.BasicTest do
  use ExUnit.Case

  test "an order with no items" do
    order = %{}

    { :error, error } = Promo.process(order)
    assert error == "order must have an items key"
  end

  test "an order with items key pointing to a non-list" do
    order = %{items: %{}}

    { :error, error } = Promo.process(order)
    assert error == "items must be specified as a list"
  end

  test "an order with a single line item" do
    order = %{
      items: [
        %{ price: 20 },
      ]
    }

    { :ok, order } = Promo.process(order)
    assert(order.total == 20)
  end

  test "an order with two line items" do
    order = %{
      items: [
        %{ price: 20 },
        %{ price: 10 }
      ]
    }

    { :ok, order } = Promo.process(order)
    assert(order.total == 30)
  end
end
