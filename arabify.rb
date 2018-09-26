#!/usr/bin/ruby
# coding: utf-8

# This class contains the processing tools to convert  Geeze numbers to arabic.
class Arabify
  def initialize(str)
    @geezstrstr = str
  end

  def arabify
    split_by_100_and_padd(split_by_10000s(rollback(@geezstrstr)))
      .map { |x| x[0] * 100 + x[1] }
      .reverse.each_with_index.map { |x, i| x * (10_000**i) } .sum
  end

  private

  def convert_2digit(str)
    str.split('').sum { |x| numhash[x] }
  end

  def split_by_10000s(str)
    str.gsub(/፼$/, '፼ ').split('፼')
  end

  def split_by_100_and_padd(str)
    str.map { |x| x[-1] == '፻' ? x << ' ' : x }
       .map { |x| x.split('፻').map { |y| convert_2digit(y) } }
       .each { |x| x.length == 1 && x.prepend(0) }
  end

  def rollback(str)
    str
      .gsub('፼፻', '፼፩፻')
      .gsub(/^፻/, '፩፻')
      .gsub('፼፼', '፼ ፼')
      .gsub('፼፼', '፼ ፼')
      .gsub(/^፼/, '፩፼')
  end

  def numhash
    Hash['፩' => 1, '፪' => 2, '፫' => 3, '፬' => 4,
         '፭' => 5, '፮' => 6, '፯' => 7, '፰' => 8,
         '፱' => 9, '፲' => 10, '፳' => 20, '፴' => 30,
         '፵' => 40, '፶' => 50, '፷' => 60, '፸' => 70,
         '፹' => 80, '፺' => 90, ' ' => 0]
  end
end
