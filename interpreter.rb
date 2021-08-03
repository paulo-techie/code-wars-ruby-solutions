
class Interpreter

  def initialize
    @vars = {}
  end  

  def interpret(expr)
    return expr if !expr || expr == ""
    return @vars[expr] if @vars[expr] && expr.length == 1
    if @vars[expr]
      return @vars[expr]
    else
      raise Exception.new 'error'
    end if expr.length == 1
    arr = expr.gsub(/\s/, '').split('=')
    x = expr.index('=')
    expr = expr[(x+1)..-1] if x

    symbol = arr[0] if arr && arr.length > 1
    @vars[symbol] = interpret(expr) if arr.length > 1
    @vars.each{|k,v| expr.gsub!(k, v.to_s)}
    stack = []
    process(remove_brackets(expr)).each{|a| load_stack(stack, a)}
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
      elsif ['+', '-', '*', '/', '%'].include?(i)
        stack = load_stack(stack, a.to_f) if a != ''
        a = ''
        if i == '-'
          if stack[-1] && stack[-1] == '-'
            stack.pop
            i = '+'
          else
            stack.push(i)
          end
        elsif i == '*' || i == '/' || i == '%'
          stack.push(i)
        end
      else
        a += i
      end
    end
    stack
  end

  def load_stack tempstack, a
        if ['+', '-', '*', '/', '%'].include?(a)
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
        elsif tempstack[-1] == '%' && tempstack[-2] && !(tempstack[-2].is_a?(String))
          tempstack.pop
          tempstack.push(tempstack.pop%a.to_f)
        else
          tempstack.push(a.to_f)
        end
    tempstack
  end

  def remove_brackets str
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

end

test = Interpreter.new

  puts test.interpret("2 * 3") == 6 # "input: '2 * 3'")
    # end

  puts test.interpret("8 / 4") == 2 # "input: '8 / 4'")
    # end

  puts test.interpret("7 % 4") == 3 # "input: '7 % 4'")
    # end
   
  puts test.interpret("4 + 2 * 3") == 10 # "input: '4 + 2 * 3'")
  puts test.interpret("4 / 2 * 3") == 6 # "input: '4 / 2 * 3'")
  puts test.interpret("7 % 2 * 8") == 8 # "input: '7 % 2 * 8'")
    # end

  puts test.interpret("x = 7") == 7 # "input: 'x = 7'")
    # end

  puts test.interpret("x") == 7 # "input: 'x'")
    # end

  puts test.interpret("x + 3") == 10 # "input: 'x + 3'")
    # end

    # it "Should throw an error when variables don't exist" do
    #     Test.expect_error "input: 'y'" do interpret("y") end
    # end

  puts test.interpret("y = x + 5") == 12 # "input: 'y = x + 5'")
    puts test.interpret("y") == 12 # "input: 'y'")
    # end

    # it "Should handle chained assignment" do
    puts test.interpret("x = y = 713") == 713 # "input: 'x = y = 713'")
    puts test.interpret("x") == 713 # "input: 'x'")
    puts test.interpret("y") == 713 # "input: 'y'")
    # end

    puts test.interpret("x = 29 + (y = 11)") == 40 # "input: 'x = 29 + (y = 11)'")
    puts test.interpret("x") == 40 # "input: 'x'")
    puts test.interpret("y") == 11 # "input: 'y'")
