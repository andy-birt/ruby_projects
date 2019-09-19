def caesar_cipher(str, num)
  cipher = ""
  str.split("").each do |c|
    if c.match(/\p{Ll}/)
      if c.ord+num < 'a'.ord
        cipher << (c.ord+num+26).chr
      elsif c.ord+num > 'z'.ord
        cipher << (c.ord+num-26).chr
      else
        cipher << (c.ord+num).chr
      end
    elsif c.match(/\p{Lu}/)
      if c.ord+num < 'A'.ord
        cipher << (c.ord+num+26).chr
      elsif c.ord+num > 'Z'.ord
        cipher << (c.ord+num-26).chr
      else
        cipher << (c.ord+num).chr
      end
    else
      cipher << c
    end
  end
  return cipher
end