defmodule Smart.ApplicationTest do
  use ExUnit.Case
  doctest Smart.Application

  test "test childrens" do
    assert Smart.Application.env_children(:test) == []
  end
end
