def substrings str, arr
  res = {}
    arr.each do |word|
      res[word] = str.downcase.scan(word).count unless str.downcase.scan(word).count == 0
    end
  res
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)