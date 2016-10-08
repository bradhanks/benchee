defmodule Benchee.Conversion.CountTest do
  use ExUnit.Case
  import Benchee.Conversion.Count
  doctest Benchee.Conversion.Count

  test ".scale 123_456_789_012 scales to :billion" do
    assert scale(123_456_789_012) == {123.456789012, unit_for(:billion)}
  end

  test ".scale 12_345_678_901 scales to :billion" do
    assert scale(12_345_678_901) == {12.345678901, unit_for(:billion)}
  end

  test ".scale 1_234_567_890 scales to :billion" do
    assert scale(1_234_567_890) == {1.23456789, unit_for(:billion)}
  end

  test ".scale 123_456_789 scales to :million" do
    assert scale(123_456_789) == {123.456789, unit_for(:million)}
  end

  test ".scale 12_345_678 scales to :million" do
    assert scale(12_345_678) == {12.345678, unit_for(:million)}
  end

  test ".scale 1_234_567 scales to :million" do
    assert scale(1_234_567) == {1.234567, unit_for(:million)}
  end

  test ".scale 123_456.7 scales to :thousand" do
    assert scale(123_456.7) == {123.4567, unit_for(:thousand)}
  end

  test ".scale 12_345.67 scales to :thousand" do
    assert scale(12_345.67) == {12.34567, unit_for(:thousand)}
  end

  test ".scale 1_234.567 scales to :thousand" do
    assert scale(1_234.567) == {1.234567, unit_for(:thousand)}
  end

  test ".scale 123.4567 scales to :one" do
    assert scale(123.4567) == {123.4567, unit_for(:one)}
  end

  test ".scale 12.34567 scales to :one" do
    assert scale(12.34567) == {12.34567, unit_for(:one)}
  end

  test ".scale 1.234567 scales to :one" do
    assert scale(1.234567) == {1.234567, unit_for(:one)}
  end

  test ".scale 0.001234567 scales to :one" do
    assert scale(0.001234567) == {0.001234567, unit_for(:one)}
  end

  test ".format(1_000_000)" do
    assert format(1_000_000) == "1.00 M"
  end

  test ".format(1_000.1234)" do
    assert format(1_000.1234) == "1.00 K"
  end

  test ".format(123.4)" do
    assert format(123.4) == "123.40"
  end

  test ".format(1.234)" do
    assert format(1.234) == "1.23"
  end

  @list_with_mostly_ones [1, 100, 1_000]

  test ".best when list is mostly ones" do
    assert best(@list_with_mostly_ones) == unit_for(:one)
  end

  test ".best when list is mostly ones, strategy: :smallest" do
    assert best(@list_with_mostly_ones, strategy: :smallest) == unit_for(:one)
  end

  test ".best when list is mostly ones, strategy: :largest" do
    assert best(@list_with_mostly_ones, strategy: :largest) == unit_for(:thousand)
  end

  @list_with_thousands_and_millions_tied_for_most [0.0001, 1, 1_000, 100_000, 1_000_000, 10_000_000, 1_000_000_000]

  test ".best when list has thousands and millions tied for most, billions highest" do
    assert best(@list_with_thousands_and_millions_tied_for_most) == unit_for(:million)
  end

  test ".best when list has thousands and millions tied for most, billions highest, strategy: :smallest" do
    assert best(@list_with_thousands_and_millions_tied_for_most, strategy: :smallest) == unit_for(:one)
  end

  test ".best when list has thousands and millions tied for most, billions highest, strategy: :largest" do
    assert best(@list_with_thousands_and_millions_tied_for_most, strategy: :largest) == unit_for(:billion)
  end

  @list_with_mostly_thousands [1_000, 2_000, 30_000, 999]

  test ".best when list is mostly thousands" do
    assert best(@list_with_mostly_thousands) == unit_for(:thousand)
  end

  test ".best when list is mostly thousands, strategy: :smallest" do
    assert best(@list_with_mostly_thousands, strategy: :smallest) == unit_for(:one)
  end

  test ".best when list is mostly thousands, strategy: :largest" do
    assert best(@list_with_mostly_thousands, strategy: :largest) == unit_for(:thousand)
  end

  test ".best when list is mostly thousands, strategy: :none" do
    assert best(@list_with_mostly_thousands, strategy: :none) == unit_for(:one)
  end
end
