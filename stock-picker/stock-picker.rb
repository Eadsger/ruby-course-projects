def stock_picker(prices)
  if prices.nil? || prices.length < 2
    puts "Not enough data to make a profit."
    return nil
  end

  max_profit = 0
  buy_day = 0
  sell_day = 0

  prices.each_with_index do |buy_price, buy_index|
    (buy_index + 1).upto(prices.length - 1) do |sell_index|
      sell_price = prices[sell_index]
      current_profit = sell_price - buy_price

      if current_profit > max_profit
        max_profit = current_profit
        buy_day = buy_index
        sell_day = sell_index
      end
    end
  end

  if max_profit > 0
    puts "Buy on day #{buy_day} and sell on day #{sell_day} for a profit of $#{max_profit}."
    return [buy_day, sell_day]
  else
    puts "No profitable transactions found."
    return nil
  end
end

# Example usage:
stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
