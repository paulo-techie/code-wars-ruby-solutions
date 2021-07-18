require 'colorize'

def calc expression
  stack = []
  process(remove_brackets(expression.gsub(/\s/, ''))).each{|a| load_stack(stack, a)}
  stack.reduce(:+)
end

def process expression  
  a, stack = '', []
  b = expression.length
  expression.chars.each_with_index do |i,o|
    if o == expression.length-1
      a += i
      stack = load_stack(stack, a.to_f) if a != ''
    elsif i == '.'
      a += i
    elsif ['+', '-', '*', '/'].include?(i)
      if !a.is_a? String
        a = a.to_s
      end
      stack = load_stack(stack, a.to_f) if a != ''
      a = ''
      if i == '-'
        if stack[-1] && stack[-1] == '-'
          stack.pop
          i = '+'
        else
          stack.push(i)
        end
      elsif i == '*' || i == '/'
        stack.push(i)
      end
    else
      a += i
    end
  end
  stack
end

def load_stack tempstack, a
      if ['+', '-', '*', '/'].include?(a)
        if a == '-' && tempstack[-1] && tempstack[-1] == '-'
          tempstack.pop
          tempstack.push('+')
          return tempstack
        end
        tempstack.push(a)
      elsif tempstack[-1] == '*' && tempstack[-2] && !(tempstack[-2].is_a?(String))
        tempstack.pop
        tempstack.push(tempstack.pop*a.to_f)
      elsif tempstack[-1] == '-'
        tempstack.pop
        tempstack.push((-1)*a.to_f)
      elsif tempstack[-1] == '/' && tempstack[-2] && !(tempstack[-2].is_a?(String))
        tempstack.pop
        tempstack.push(tempstack.pop/a.to_f)
      elsif tempstack[-1] == '+' && tempstack[-2] && !(tempstack[-2].is_a?(String))
        tempstack.pop
        tempstack.push(tempstack.pop+a.to_f)
      else
        tempstack.push(a.to_f)
      end
  tempstack
end

def remove_brackets expression
  str = expression # make a copy of expresion to work with
  brackets = true
  tempstack = []
  i = 0 # starting index
  loop do
    b = str[i..-1].index(')')
    c = str[i..b.to_i].reverse.index('(')
    brackets = false unless b && c
    break if brackets == false
    result = (str[(b-c+1)..(b-1)])
    process(result).each do |a|
      tempstack = load_stack(tempstack, a)
    end
    str[(b-c)..b] = tempstack.reduce(:+).to_s
    tempstack = []
  end
  str
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
