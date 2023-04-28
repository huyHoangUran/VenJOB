class Convert
  KANJI_MAP = { 0 => '〇', 1 => '一', 2 => '二', 3 => '三', 4 => '四', 5 => '五', 6 => '六', 7 => '七', 8 => '八', 9 => '九' }.freeze
KANJI_MAP_REVERSE = KANJI_MAP.invert.freeze

def to_kansuji(number=0)
    if number == 0
        return KANJI_MAP[0] 
    end
  result = ''
  if number < 0
    result += 'マイナス'
    number = -number
  end
  thousands = number / 1000
  if thousands > 0
    result += to_kansuji(thousands) + '千' 
  end
  hundreds = (number / 100) % 10
  if hundreds > 0
  result += KANJI_MAP[hundreds] + '百'
  end
  tens = (number / 10) % 10
  if tens > 0 && hundreds == 0
  result += '十' 
  end   
  if tens > 1 && hundreds != 0
  result += KANJI_MAP[tens] + '十' 
  end
  if tens == 1 && hundreds != 0
    result += KANJI_MAP[1] + '十' 
  end
  ones = number % 10
  if ones > 0
    result += KANJI_MAP[ones] 
  end

  result
end

def to_number(kansuji)
  number = 0
  thousands = 0
  hundreds = 0
  tens = 0
  ones = 0

  kansuji.chars.each do |char|
    if char == 'マ'
      number = -number
    elsif char == '千'
      number += thousands * 1000
      thousands = 0
    elsif char == '百'
      number += hundreds * 100
      hundreds = 0
    elsif char == '十'
      if hundreds == 0
        tens = 1
      else
        number += (tens + 1) * 10
        tens = 0
      end
    else
      value = KANJI_MAP_REVERSE[char]
      if tens > 0
        number += (tens + 1) * value
        tens = 0
      elsif hundreds > 0
        number += hundreds * 100 + value
        hundreds = 0
      elsif thousands > 0
        number += thousands * 1000 + value
        thousands = 0
      else
        ones = value
      end
    end
  end

  number += thousands * 1000 + hundreds * 100 + (tens + 1) * 10 + ones
  number
end
end
 
conver = Convert.new
puts "nhap vao so muon chuyen"
num = gets.chomp().to_i
puts conver.to_kansuji(num)


