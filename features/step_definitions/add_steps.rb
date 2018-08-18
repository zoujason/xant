# encoding: UTF-8

假如(/^输入一个 "(.*?)"$/) do |input|
  @input = input
end

当(/^计算器运行时$/) do
  @output = eval("#{@input}")
end

那么(/^输出应该是 "(.*?)"$/) do |output|
  @output == output
end