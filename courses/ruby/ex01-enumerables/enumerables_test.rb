# frozen_string_literal: true

require "minitest/autorun"
require "minitest/pride"

class EnumerablesTest < Minitest::Test
  def test_squares_each
    numbers = [1, 2, 3, 4, 5]
    actual = []
    numbers.each do |number|
      actual << number**2
    end
    assert_equal [1, 4, 9, 16, 25], actual
  end

  def test_squares
    numbers = [1, 2, 3, 4, 5]
    actual = numbers.map do |number|
      number**2
    end
    assert_equal [1, 4, 9, 16, 25], actual
  end

  def test_find_waldo_each
    words = %w[noise dog fair house waldo bucket fish]
    actual = nil
    words.each do |word|
      actual = word if word == "waldo"
    end
    assert_equal "waldo", actual
  end

  def test_find_waldo
    words = %w[noise dog fair house waldo bucket fish]
    actual = words.find do |word|
      word if word == "waldo"
    end
    assert_equal "waldo", actual
  end

  def test_pick_words_with_three_letters_each
    words = %w[pill bad finger cat blue dog table red]
    actual = []
    words.each do |x|
      actual << x if x.length == 3
    end
    assert_equal %w[bad cat dog red], actual
  end

  def test_pick_words_with_three_letters
    words = %w[pill bad finger cat blue dog table red]
    actual = words.select do |word|
      word.length == 3
    end
    assert_equal %w[bad cat dog red], actual
  end

  def test_normalize_zip_codes_each
    numbers = [234, 10, 9119, 38_881]
    actual = []
    numbers.each do |x|
      actual << if x.to_s.length < 5
                  "0" * (5 - x.to_s.length) + x.to_s
                else
                  x.to_s
                end
    end
    assert_equal %w[00234 00010 09119 38881], actual
  end

  def test_normalize_zip_codes
    numbers = [234, 10, 9119, 38_881]
    actual = []
    numbers.map do |x|
      actual << x.to_s.rjust(5, "0")
    end
    assert_equal %w[00234 00010 09119 38881], actual
  end

  def test_no_waldo_each
    words = %w[scarf sandcastle flag pretzel crow key]
    found = nil
    words.each do |x|
      found = x if x == "waldo"
    end
    assert_nil found
  end

  def test_no_waldo
    words = %w[scarf sandcastle flag pretzel crow key]
    found = words.find {|x| x == "waldo" }
    assert_nil found
  end

  def test_pick_floats_each
    numbers = [3, 1.4, 3.5, 2, 4.9, 9.1, 8.0]
    actual = []
    numbers.each do |x|
      actual << x unless x.is_a?(Integer)
    end
    assert_equal [1.4, 3.5, 4.9, 9.1, 8.0], actual
  end

  def test_pick_floats
    numbers = [3, 1.4, 3.5, 2, 4.9, 9.1, 8.0]
    actual = []
    numbers.map do |x|
      actual << x if x.is_a?(Integer) == false
    end
    assert_equal [1.4, 3.5, 4.9, 9.1, 8.0], actual
  end

  def test_words_with_no_vowels_each
    words = %w[green sheep travel least boat]
    actual = []
    words.each do |str|
      tmp = []
      str.split("").each do |c|
        tmp << c unless c.match(/[aeiou]/)
      end
      actual << tmp.join("")
    end
    assert_equal %w[grn shp trvl lst bt], actual
  end

  def test_words_with_no_vowels
    words = %w[green sheep travel least boat]
    actual = []
    words.map do |str|
      res = str.split("").grep_v(/[aeiou]/)
      actual << res.join("")
    end
    assert_equal %w[grn shp trvl lst bt], actual
  end

  def test_has_at_least_one_zero_each
    numbers = [2, 0, 9, 3, 0, 1]
    actual = false
    numbers.each do |x|
      actual = true if x.zero?
    end
    assert_equal true, actual
  end

  def test_has_at_least_one_zero
    numbers = [2, 0, 9, 3, 0, 1]
    actual = numbers.any? do |x|
      x == 0
    end
    assert_equal true, actual
  end

  def test_all_gone_each
    words = %w[gone gone gone gone gone gone gone]
    actual = true
    words.each do |x|
      actual = false if x != "gone"
    end
    assert_equal true, actual
  end

  def test_all_gone
    words = %w[gone gone gone gone gone gone gone]
    actual = words.all? do |x|
      x == "gone"
    end
    assert_equal true, actual
  end

  def test_count_numbers_greater_than_17_each
    numbers = [9, 18, 12, 17, 1, 3, 99]
    actual = 0
    numbers.each do |x|
      actual += 1 if x > 17
    end
    assert_equal 2, actual
  end

  def test_count_numbers_greater_than_17
    numbers = [9, 18, 12, 17, 1, 3, 99]
    actual = numbers.count {|x| x > 17 }
    assert_equal 2, actual
  end

  def test_array_with_the_most_items_each
    arrays = [%i[a b c], [1, 2, 3, 4, 5], ["zoo", :things, :stuff]]
    actual = arrays[0]
    arrays.each do |sub_arr|
      actual = sub_arr if actual.length < sub_arr.length
    end
    assert_equal [1, 2, 3, 4, 5], actual
  end

  def test_array_with_the_most_items
    arrays = [%i[a b c], [1, 2, 3, 4, 5], ["zoo", :things, :stuff]]
    actual = arrays.max_by(&:length)
    assert_equal [1, 2, 3, 4, 5], actual
  end

  def test_group_words_by_first_letter_each
    words = %w[ant axis albatross bolt badge butter car cdr column]
    actual = Hash.new {|hash, key| hash[key] = [] }
    words.each do |x|
      if actual[x[0]]
        actual[x[0]] << x
      else
        actual[x[0]] = x
      end
    end
    expected = {"a" => %w[ant axis albatross], "b" => %w[bolt badge butter], "c" => %w[car cdr column]}
    assert_equal expected, actual
  end

  def test_group_words_by_first_letter
    words = %w[ant axis albatross bolt badge butter car cdr column]
    actual = words.group_by do |x|
      x[0]
    end
    expected = {"a" => %w[ant axis albatross], "b" => %w[bolt badge butter], "c" => %w[car cdr column]}
    assert_equal expected, actual
  end

  def test_none_are_negative_each
    numbers = [9, 3, 1, 8, 3, 3, 5]
    actual = true
    numbers.each do |x|
      actual = false if x.negative?
    end
    assert true, actual
  end

  def test_none_are_negative
    numbers = [9, 3, 1, 8, 3, 3, 5]
    actual = numbers.none? do |x|
      x.negative?
    end
    assert true, actual
  end

  def test_sum_a_list_of_numbers_each
    numbers = [32, 1, 21, 5, 81, 333]
    actual = 0
    numbers.each do |x|
      actual += x
    end
    assert_equal 473, actual
  end

  def test_sum_a_list_of_numbers
    numbers = [32, 1, 21, 5, 81, 333]
    actual = numbers.sum
    assert_equal 473, actual
  end

  def test_remove_numbers_divisible_by_3_each
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    actual = []
    numbers.each do |x|
      actual << x unless (x % 3).zero?
    end
    assert_equal [1, 2, 4, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20], actual
  end

  def test_remove_numbers_divisible_by_3
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    actual = numbers.reject do |x|
      (x % 3).zero?
    end
    assert_equal [1, 2, 4, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20], actual
  end

  def test_speed_interview_pairs_each
    list1 = %w[Alice Bob Charlie]
    list2 = %w[Xenia Yves Zach]
    actual = []
    list1.each_with_index do |x, id|
      actual << [x, list2[id]]
    end
    assert_equal [%w[Alice Xenia], %w[Bob Yves], %w[Charlie Zach]], actual
  end

  def test_speed_interview_pairs
    list1 = %w[Alice Bob Charlie]
    list2 = %w[Xenia Yves Zach]
    actual = list1.zip(list2)
    assert_equal [%w[Alice Xenia], %w[Bob Yves], %w[Charlie Zach]], actual
  end

  def test_has_a_multi_word_phrase_each
    phrases = ["Sure!", "OK.", "I have no idea.", "Really?Whatever."]
    actual = false
    phrases.each do |str|
      str.split("").each do |c|
        actual = true if c == " "
      end
    end
    assert_equal true, actual
  end

  def test_has_a_multi_word_phrase
    phrases = ["Sure!", "OK.", "I have no idea.", "Really?Whatever."]
    actual = phrases.any? do |str|
      str.include?(" ")
    end
    assert_equal true, actual
  end

  def test_count_words_that_are_uppercase_each
    words = %w[trousers SOCKS sweater Cap SHOE TIE]
    actual = 0
    words.each do |str|
      actual += 1 if str == str.upcase
    end
    assert_equal 3, actual
  end

  def test_count_words_that_are_uppercase
    words = %w[trousers SOCKS sweater Cap SHOE TIE]
    actual = 0
    words.map do |word|
      actual += 1 if word.match(/[A-Z]$/)
    end
    assert_equal 3, actual
  end

  def test_smallest_number_each
    numbers = [1, 10, 100, 1000, 10_000, 1_000_000]
    actual = numbers[0]
    numbers.each do |x|
      actual = x if x < actual
    end
    assert_equal 1, actual
  end

  def test_smallest_number
    numbers = [1, 10, 100, 1000, 10_000, 1_000_000]
    actual = numbers.min
    assert_equal 1, actual
  end

  def test_multiply_list_of_numbers_each
    numbers = [2, 3, 5, 7]
    actual = 1
    numbers.each do |x|
      actual *= x
    end
    assert_equal 210, actual
  end

  def test_multiply_list_of_numbers
    numbers = [2, 3, 5, 7]
    actual = numbers.reduce(:*)
    assert_equal 210, actual
  end

  def test_solitaire_each
    list1 = %w[Ace 6 10 Queen]
    list2 = %i[clubs diamonds hearts spades]
    actual = []
    list1.each_with_index do |x, id|
      tmp = [x, list2[id]]
      actual << tmp
    end
    assert_equal [["Ace", :clubs], ["6", :diamonds], ["10", :hearts], ["Queen", :spades]], actual
  end

  def test_solitaire
    list1 = %w[Ace 6 10 Queen]
    list2 = %i[clubs diamonds hearts spades]
    actual = list1.zip(list2)
    assert_equal [["Ace", :clubs], ["6", :diamonds], ["10", :hearts], ["Queen", :spades]], actual
  end

  def test_all_multiples_of_7_each
    numbers = [42, 14, 35, 49, 28, 56, 21, 7]
    actual = []
    numbers.each do |x|
      actual << x if (x % 7).zero?
    end
    assert actual
  end

  def test_all_multiples_of_7
    numbers = [42, 14, 35, 49, 28, 56, 21, 7]
    actual = numbers.select do |x|
      (x % 7).zero?
    end
    assert actual
  end

  def test_sort_by_number_of_cents_each
    prices = [3.02, 9.91, 7.9, 10.01, 11.0]
    tmp = []
    prices.each_with_index do |_x, ind|
      while ind != 0
        if prices[ind] % 1 < prices[ind - 1] % 1
          tmp = prices[ind]
          prices[ind] = prices[ind - 1]
          prices[ind - 1] = tmp
        end
        ind -= 1
      end
    end
    actual = prices
    assert_equal [11.0, 10.01, 3.02, 7.9, 9.91], actual
  end

  def test_sort_by_number_of_cents
    prices = [3.02, 9.91, 7.9, 10.01, 11.0]
    actual = prices.sort do |x, y|
      x % 1 <=> y % 1
    end
    assert_equal [11.0, 10.01, 3.02, 7.9, 9.91], actual
  end
end

