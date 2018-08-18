# encoding: utf-8
class MarkBuilder
  SELF_CLOSING_TAGS = [:area, :base, :br, :col, :command, :embed, :frame, :hr, :img, :input, :keygen, :link, :meta, :param, :source, :track, :wbr]

  def initialize(&block)
    @tags = []
    block.arity<1 ? self.instance_eval(&block) : block.call(self) if block_given?
  end

  def start(el, args)
    @tags << "<#{el}"
    args.each do |k, v|
      @tags << " #{k}='#{v}'"
    end
    unless SELF_CLOSING_TAGS.include?(el)
      @tags << '>'
    else
      @tags << ' />'
    end
  end

  def text(txt, &block)
    block.arity<1 ? self.instance_eval(&block) : block.call(self) if block_given?
    @tags << txt unless txt.nil?
  end

  def over(el)
    @tags << "</#{el}>"
  end

  def method_missing(method_name, *args, &block)
    tag(method_name, *args, &block)
  end

  def to_s
    @tags.join('')
  end

  private
  def tag(el, *args, &block)
    text = ''
    attrs = {}
    args.each do |arg|
      if arg.is_a?(::Hash)
        attrs.merge!(arg)
      else
        text << arg.to_s
      end
    end

    start(el, attrs)
    unless SELF_CLOSING_TAGS.include?(el)
      text(text, &block)
      over(el)
    end
  end

end
if __FILE__ == $0
  m = MarkBuilder.new do
    ul { li { a 'link', href: '#'} }
  end
  m.ul do
    li do
      a 'link', href: '#'
    end
  end
  p m.to_s #"<ul><li><a href='#'>link</a></li></ul><ul><li><a href='#'>link</a></li></ul>"
end
