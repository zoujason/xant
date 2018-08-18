# language: zh-CN
功能: 加法计算
  这是一个模拟计算器的工具，目的是演示基本的Cucumber应用。

  在这一类Cucumber文档中，你不仅可以用中文书写，而且可以做非常详尽的描述，比如我现在这样。
  你可以写一个简单的命令行程序calc.rb，然后只接收一个字符串参数，如"2+2"。

  从用户角度测试时，我们是把命令行程序与参数字符串连接起来调用的，即"calc.rb 2+2"，而我们会对屏幕输出的结果进行校验，案例在场景大纲的例子中给出。

  场景大纲: 两数相加
    假如输入一个 "<input>"
    当计算器运行时
    那么输出应该是 "<output>"

    例子:
      | input | output |
      | 2+2   | 4      |
      | 98+1  | 99     |