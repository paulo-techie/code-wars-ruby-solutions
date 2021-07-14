require 'colorize'

def calc expression  
  expression = expression.gsub(/\s/, '')
  expression = remove_brackets(expression)
  process(expression).reduce(:+)
end

def load_stack(tempstack, a)
  if ['+', '-', '*', '/'].include?(a)
    if a == '-' && tempstack[-1] && tempstack[-1] == '-'
      tempstack.pop
      return tempstack
    end
    tempstack.push(a)
  elsif tempstack[-1] == '*' && tempstack[-2] && !(tempstack[-2].is_a?(String))
    tempstack.pop
    tempstack.push(tempstack.pop * a.to_f)
  elsif tempstack[-1] == '-'
    tempstack.pop
    tempstack.push(a.to_f * -1) # = load_stack(tempstack, a)  # recursion
  elsif tempstack[-1] == '/' && tempstack[-2] && !(tempstack[-2].is_a?(String))
    tempstack.pop
    tempstack.push(tempstack.pop / a.to_f)
  elsif tempstack[-1] == '+' && tempstack[-2] && !(tempstack[-2].is_a?(String))
    tempstack.pop
    tempstack.push(tempstack.pop + a.to_f)
  else
    tempstack.push(a.to_f)
  end
  tempstack
end

def remove_brackets expression
  str = expression # make a copy of expresion to work with
  tempstack = []
  i = 0 # starting index
  loop do
    b = str[i..-1].index(')')
    c = str[i..b.to_i].reverse.index('(')
    brackets = false unless b && c
    break if brackets == false
    result = (str[(b-c+1)..(b-1)])
    process(result).each { |a| tempstack = load_stack(tempstack, a) }
    if tempstack.any?{|o| o.is_a?(String)}
      str[(b-c)..b] = tempstack.join
    else
      str[(b-c)..b] = tempstack.reduce(:+).to_s
    end
    tempstack = []
  end
  str
end

def process(expression)
  c_arr = []
  a = ''
  expression.chars.each do |c|
    if ['+', '-', '*', '/'].include?(c)
      c_arr << a if a != ''
      if c_arr[-1] && c_arr[-1] == '-' and c == '-'
        c_arr.pop
        next
      end
      c_arr << c
      a = ''
      next
    end
    a += c
  end
  c_arr << a 
  c_arr.each {}
  c_arr
end

tests = [
  ['(1+1)', 2],
  ['((1 - 1)) + 1', 1],
  ['1* 1', 1],
  ['1+(1 /1) + (1+1)', 4],
  ['-123', -123],
  ['123', 123],
  ['(2 / 2) +3 * 4.75- -6', 21.25],
  ['12* 123', 1476],
  ['2 / (2 + 3) * 4.33 - -6', 7.732]
]

tests2 = [
    ['12*-1', -12],
    ['12* 123/-(-5 + 2)', 492],
    ['-((80 - (19)))', -61],
    ['(1 - 2) + -(-(-(-4)))', 3],
    ['1 - -(-(-(-4)))', -3],
    ['12* 123/(-5 + 2)', -492],
    ['1+1', 2],
    ['1 - 1', 0],
    ['1* 1', 1],
    ['1 /1', 1],
    ['-123', -123],
    ['123', 123],
    ['2 /2+3 * 4.75- -6', 21.25],
    ['12* 123', 1476],
    ['12 * -123', -1476],
    ['2 / (2 + 3) * 4.33 - -6', 7.732],
    ['((2.33 / (2.9+3.5)*4) - -6)', 7.45625],
    ["2 + 3 * 4 / 3 - 6 / 3 * 3 + 8", 8],
    ["1 + 2 * 3 * 3 - 8", 11],
    ["1 + 2 * 3 * (5 - 2) - 8", 11],
    ["1 + 2 * 3 * (5 - (3 - 1)) - 8", 11],
    ["4 + -(1)", 3],
    ["4 - -(1)", 5],
    ["4 * -(1)", -4],
    ["4 / -(1)", -4],
    ["-1", -1],
    ["-(-1)", 1],
    ["-(-(-1))", -1],
    ["-(-(-(-1)))", 1],
    ["(((((-1)))))", -1],
    ["5 - 1", 4],
    ["5- 1", 4],
    ["5 -1", 4],
    ['(123.45*(678.90 / (-2.5+ 11.5)-(((80 -(19))) *33.25)) / 20) - (123.45*(678.90 / (-2.5+ 11.5)-(((80 -(19))) *33.25)) / 20) + (13 - 2)/ -(-11)', 1]
];

tests.each do |t|
  if calc(t[0]) == t[1]
    puts 'Passed✔'.green
  else
    puts 'Failed✕'.red
  end
end

tests2.each do |t|
  if calc(t[0]) == t[1]
    puts 'Passed✔'.green
  else
    puts 'Failed✕'.red
  end
end
