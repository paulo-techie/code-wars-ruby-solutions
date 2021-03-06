require 'eval_math'

describe 'EvalMath' do

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

  describe "calc" do
    context "Given a string of expression" do
      it 'return true for every line' do
        tests.each do |pair|
          expect calc(pair[0]).to eq(calc(pair[1]))
        end
      end
    end
  end

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
      ['(1*(1 / (1)-(1) *1)) / 1) - (1*(1 / (1)-(1) *1) / 1) + (1)/1) ', 1],
      ['(123.45*(678.90 / (-2.5+ 11.5)-(80 -19) *33.25)) / 20) - (123.45*(678.90 / (-2.5+ 11.5)-(80 -19) *33.25) / 20) + (13 - 2)/11) ', 1]
  ];


  describe "calc" do
    context "Given a string of expression" do
      it 'return true for every line' do
        tests2.each do |pair|
          expect calc(pair[0]).to eq(calc(pair[1]))
        end
      end
    end
  end
  
end
