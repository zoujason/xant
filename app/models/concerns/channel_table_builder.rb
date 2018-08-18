class ChannelTableBuilder
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
        th '模板','class':'hidden-xs'
        th '操作','class':'text-center'
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
          td child.tpl,'class':'hidden-xs'
          td 'class':'center' do
            div 'class':'visible-md visible-lg hidden-sm hidden-xs' do
              a 'class':"btn btn-xs btn-green tooltips btn-wrap", 'data-placement':"top", title:"", href: "/xmt/press/channels/#{child.id}?site_id=#{me.site.id}", 'data-original-title':"查看" do
                i 'class': "fa fa-eye"
              end

              a 'class':"btn btn-xs btn-teal tooltips btn-wrap", 'data-placement':"top", title:"", href: "/xmt/press/channels/#{child.id}/edit?site_id=#{me.site.id}", 'data-original-title':"修改" do
                i 'class': "fa fa-edit"
              end
              a 'class':"btn btn-xs btn-bricky tooltips btn-wrap", 'data-placement':"top", title:"", href: "/xmt/press/channels/#{child.id}?site_id=#{me.site.id}", 'data-original-title':"删除", 'data-confirm': "确认删除?", rel: "nofollow", 'data-method': "delete" do
                i 'class': "fa fa-times"
              end
            end

            div 'class':'visible-xs visible-sm hidden-md hidden-lg' do
              div 'class': 'btn-group' do
                a 'class': 'btn btn-primary dropdown-toggle btn-sm','data-toggle':'dropdown','hraf':'#' do
                  i 'class':'clip-cog'
                  span 'class': 'caret'
                end
                ul 'class':'dropdown-menu pull-right', 'role':'menu' do
                  li 'role':'presentation' do
                    a 'role':'menuitem' ,'tabindex':'-1' ,'href':"/xmt/press/channels/#{child.id}/edit?site_id=#{me.site.id}" do
                      i 'class':'clip-pencil'do

                      end
                      e 'Edit'
                    end
                  end
                  li 'role':'presentation' do
                    a 'role':'menuitem' ,'tabindex':'-1' ,'href':"/xmt/press/channels/#{child.id}?site_id=#{me.site.id}" do
                      i 'class':'fa fa-share'do

                      end
                      e 'share'
                    end
                  end
                  li 'role':'presentation' do
                    a 'role':'menuitem' ,'tabindex':'-1' ,'href':"/xmt/press/channels/#{child.id}?site_id=#{me.site.id}", 'data-confirm': "Are you sure?", rel: "nofollow", 'data-method': "delete"  do
                      i 'class':'clip-close-2'do

                      end
                      e 'Remove'
                    end
                  end
                end
              end
            end
          end
        end

      end

    end
  end

  def to_s
    @tag.to_s
  end
end