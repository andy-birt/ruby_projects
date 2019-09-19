def stock_picker days
  profit = 0
  res = []
  for day in days do
    i = days.index(day)
    for j in days[i..-1]
      if j - day > profit
        profit = j - day
        res = [i, days.index(j)]
      end
    end
  end
  res
end