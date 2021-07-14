def calc expression  
  expression = expression.gsub(/\s/, '')
  process(expression).reduce(:+)
end

def process expression  
  a, stack, float, brackets = '', [], false, false
  b = expression.length
  expression.chars.each_with_index do |i,o|
    next if brackets && o < b
    brackets = false
    if o == expression.length-1
      a = a.to_s
      if a.is_a? String
        a += i
      else 
        a = a.to_s
      end
      stack = load_stack(stack, a, float) if a != ''
    elsif i == ')'
      next
    elsif i == '('
      brackets = true
      b = expression[o..expression.length].index(')') ? o + expression[o..expression.length].index(')') : expression.length
      result = process(expression.chars[(o+1)..(b-1)].join) # use recursion to deal with bracketed sub-expressions
      
      if result.size > 1 && result.any?{|r| r.is_a? String}
          result.each{|a| stack = load_stack(stack, a, float)}
      elsif result
         stack = load_stack(stack, result.reduce(:+), float)
      end
      next
    elsif i == '.'
      float = true
      a += i
    elsif i == '+' || i == '/' || i == '*' || i == '-'
      if !a.is_a? String
        a = a.to_s
      end
      stack = load_stack(stack, a, float) if a != ''
      float = false
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

def load_stack stack, a, float
  if stack[-1] == '*'
    stack.pop
    stack.push(a.to_i*stack.pop)  if !float
    stack.push(a.to_f*stack.pop)  if float
  elsif stack[-1] == '/'
    stack.pop
    stack.push(stack.pop/a.to_f)
  elsif stack[-1] == '-'
    stack.pop
    a = a.to_f * -1 if float
    a = a.to_i * -1 if !float
    stack = load_stack stack, a, float  # recursion
  else
    stack.push(a.to_f)
  end
  stack
end

