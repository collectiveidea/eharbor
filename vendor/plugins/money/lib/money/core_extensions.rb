class Numeric
  # Convert the number to a +Money+ object.
  #
  #   100.to_money      #=> #<Money @cents=10000>
  #
  # Takes an optional precision, which defaults to 2
  def to_money(precision = 2)
    Money.new(self * 10**precision, Money.default_currency, precision)
  end
end

class Float
  # Convert the float to a +Money+ object.
  #
  #   3.75.to_money     #=> #<Money @cents=375>
  #
  # It takes an optional precision, which defaults to 2 or the number of digits
  # after the decimal point if it's more than 2.
  def to_money(precision = nil)
    to_s.to_money(precision)
  end
end

class String
  # Convert the String to a +Money+ object.
  #
  #   '100'.to_money    #=> #<Money @cents=10000>
  #   '100.37'.to_money #=> #<Money @cents=10037>
  #
  # It takes an optional precision argument which defaults to 2 or the number of
  # digits after the decimal point if it's more than 2.
  #
  #   '3.479'.to_money  # => #<Money @cents=3479 @precision=3>
  #
  def to_money(precision = nil)
    # Get the currency
    matches = scan /([A-Z]{2,3})/ 
    currency = matches[0] ? matches[0][0] : Money.default_currency
    
    if !precision
      precision = scan(/\.(\d+)/).to_s.length
      precision = 2 if precision < 2
    end
    
    # Get the cents amount
    matches = scan /(\-?[\d,]+(\.(\d+))?)/
    cents = matches[0] ? (matches[0][0].gsub(',', '').to_f * 10**precision) : 0
    
    Money.new(cents, currency, precision)
  end
end
