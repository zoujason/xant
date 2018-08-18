class AdminMenuMgr
  include ::Singleton
  attr_reader :items

  def initialize
    @menu = Xmt::Nav::Menu.find_by(sign: :sys_menu)
    @css = ['main-navigation-menu', 'sub-menu']
    @items = []

    load()
  end

  def load
    @items = @menu.descendants.to_a
  end
  alias reload load

  def find_by_parent_id(parent_id)
    @items.select { |item| item.parent_id == parent_id }
  end

  def find(id)
    @items.find { |item| item.id.to_s == id.to_s }
  end

  def render_item(parent)
    change = @item_selected
    me = self
    css = @css
    children = find_by_parent_id(parent.id)

    if children.size > 0
      @tag.ul 'class': css[parent.depth] do
        children.each do |item|
          selected = change&&( change.id == item.id || change.descendant_of?(item))
          li 'class': selected ? 'active open' : '' do
            a href: item.path + "?m_id=#{item.id}" do
              i 'class': item.icon
              span item.name , 'class': 'title'
              i 'class': 'icon-arrow' if me.find_by_parent_id(item.id).size > 0
              span 'class': 'selected' if selected
            end
            me.render_item(item)
          end if Waas::Security.subject.allow(item.id, :view)
        end
      end
    end
  end

  def render(m_id = nil)
    @tag = MarkBuilder.new
    @item_selected = find(m_id)
    render_item @menu
    @tag.to_s
  end

end