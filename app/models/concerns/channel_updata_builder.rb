class ChannelUpdateBuilder
  attr_reader :site
  def initialize(site)
    @site = site
    @tag = MarkBuilder.new
    #@channels = Channel.where(parent_ids: @site.id).order_by(parent_ids: -1)
    @channel_map = ChannelMap.new(@site)
  end

  def build
    me = self
    channel = @site
    @tag.table 'class': 'table table-striped table-bordered table-hover table-full-width','id':'sample-table-1' do
      thead do
        th '名称'
        th '文章数量','class':'hidden-xs center'
        th '最后更新时间','class':'hidden-xs center'
        th '显示状态','class':'center'
      end
      tbody do
        me.line(channel)
      end
    end
  end

  def line(item)

    me = self
    @channel_map.traversal do |child|
      if Waas::Security.subject.allow(child.id,'visite')
        @tag.tr do
          td child.title,style: "padding-left: #{child.depth}em"
          td child.channels.count>0 ? "下属有子栏目" : child.articles.count,'class':'hidden-xs center'
          td  child.channels.count>0 ?  '' :child.articles.count>0 ? child.articles.last.try(:updated_at).strftime('%Y-%m-%d') : "没有数据" ,'class':'hidden-xs center'
          td  child.channels.count>0 ?  '' :child.articles.count>0 ? (Time.now.to_i - child.articles.last.try(:updated_at).to_i)/(24*60*60)>0 ? ((Time.now.to_i - child.articles.last.try(:updated_at).to_i)/(24*60*60)).to_s+'天未更新' :"已更新" : "" ,'class':'center'
        end

      end

    end
  end
  def to_s
    @tag.to_s
  end
end