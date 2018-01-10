defmodule Promo.ItemTest do
  use ExUnit.Case
  alias Promo.Item

  test "sums up items" do
    total = Item.sum([
      %{price: 10},
      %{price: 20},
    ])

    assert total == 30
  end
end
