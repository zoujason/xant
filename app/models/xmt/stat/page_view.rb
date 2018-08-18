module Xmt
  module Stat
    class PageView
      include Mongoid::Document
      include Mongoid::Timestamps::Created

      field :ip
      field :referer
      field :url
      field :uv_id #session_id
      field :title
      field :page_parent_ids, type: Array
      field :page_klass
      field :page

      belongs_to :page, class_name: 'Xmt::Press::Page', required: false
      belongs_to :user, class_name: 'Xmt::Staff::User', required: false

      set_callback :save, :before do |doc|
        self.page_klass = doc.page.class.to_s
        self.page_parent_ids = doc.page.parent_ids + [doc.page.id]
      end

      def self.hits_per_page
        map = %q{
                function(){
                  emit(this.page_id,  {title:this.title} );
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {hits: 0, title:''};
                      values.forEach(function(value) {
                        result.hits += 1;
                        result.title = value.title
                      });
                      return result;
                    }
                  }

        self.map_reduce(map, reduce).out(inline: 1)
      end

      def self.page_per_day(channel_id, year, month)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {days: [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.days[date.getDate() - 1] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year, month)
        opts = {}
        opts[:site_id] = channel_id
        opts[:dt] = dt
        stat_info = self.where(page_parent_ids: opts[:site_id],page_klass:'Xmt::Press::Channel', :created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year,:created_at.gt => dt.at_beginning_of_month,:created_at.lte => dt.at_end_of_month)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end
      end

      def self.page_per_month(channel_id, year)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {months: [0,0,0,0,0, 0,0,0,0,0, 0,0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.months[date.getMonth()] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year)
        opts = {}
        opts[:site_id] = channel_id
        opts[:dt] = dt
        stat_info = self.where(page_parent_ids: opts[:site_id],page_klass:'Xmt::Press::Channel', :created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end
        # stat_info.map_reduce(map, reduce).out(inline: 1)
      end

      def self.site_per_day(site_id, year, month)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {days: [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.days[date.getDate() - 1] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year, month)
        opts = {}
        opts[:site_id] = site_id
        opts[:dt] = dt
        stat_info = self.where(page_parent_ids: opts[:site_id],page_klass:'Xmt::Press::Article', :created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year,:created_at.gt => dt.at_beginning_of_month,:created_at.lte => dt.at_end_of_month)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end
        # stat_info.map_reduce(map, reduce).out(inline: 1)
      end

      def self.site_single_per_day(site_id, year, month)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {days: [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.days[date.getDate() - 1] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year.to_i, month.to_i)
        stat_info = self.where(page_parent_ids: site_id, page_klass:'Xmt::Press::Site',:created_at.gt => dt.at_beginning_of_year, :created_at.lte => dt.at_end_of_year,:created_at.gt => dt.at_beginning_of_month,:created_at.lte => dt.at_end_of_month)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end

      end

      def self.site_single_per_month(site_id, year)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {months: [0,0,0,0,0, 0,0,0,0,0, 0,0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.months[date.getMonth()] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year)
        opts = {}
        opts[:site_id] = site_id
        opts[:dt] = dt
        stat_info = self.where(page_parent_ids: opts[:site_id],page_klass:'Xmt::Press::Site', :created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end

      end

      def self.site_per_month(site_id, year)
        map = %q{
                function(){
                  emit({page_klass: this.page_klass, title:this.title}, {created_at: this.created_at});
                }
              }

        reduce = %q{
                    function(key, values) {
                      var result = {months: [0,0,0,0,0, 0,0,0,0,0, 0,0]};
                      var date = null;
                      values.forEach(function(value) {
                        if (value.created_at != null){
                           date = new Date(value.created_at);
                           result.months[date.getMonth()] += 1;
                        }
                      });
                      return result;
                    }
                  }
        dt =  DateTime.new(year)
        opts = {}
        opts[:site_id] = site_id
        opts[:dt] = dt
        stat_info = self.where(page_parent_ids: opts[:site_id], page_klass:'Xmt::Press::Article',:created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year)
        if stat_info.count < 2
          return []
        else
          stat_info.map_reduce(map, reduce).out(inline: 1)
        end
        # stat_info.map_reduce(map, reduce).out(inline: 1)
      end

      def self.stat_info_method(opts,map,reduce)
        stat_info = self.where(page_parent_ids: opts[:site_id], :created_at.gt => opts[:dt].at_beginning_of_year, :created_at.lte => opts[:dt].at_end_of_year)
        stat_data_info(stat_info,map,reduce)
      end

      def self.stat_data_info(stat_info,map,reduce)
        if stat_info.count == 0
          return []
        else
          stat_info.each do |info|
            info = Xmt::Stat::PageView.where(title: info.title).to_a
            if info.count < 2
              info.destroy
            end
          end
          return stat_info.map_reduce(map, reduce).out(inline: 1)
        end
      end

      def self.get_now_year
        DateTime.now.to_s[0,4].to_i
      end

      def self.get_now_month
        month = DateTime.now.to_s[5,2]
        if month[0,1] == '0'
          month = DateTime.now.to_s[5,2][1,1].to_i
        end
        month.to_i
      end

      # 对数组分页->统计页面以及文章访问
      def self.paginate_array(page_years,page,date)
        @info = []
        page_years.each do |page_year|
          info = Array.new
          page_klass = page_year.to_a[0][1][:page_klass]
          title = page_year.to_a[0][1][:title]
          months = page_year.to_a[1][1][:"#{date}"]
          info.push(page_klass)
          info.push(title)
          info.push(months)
          @info.push(info)
        end
        Kaminari.paginate_array(@info, total_count: @info.size).page(page).per(15)
      end

      def self.paginate_array_channel(page_years,page,date)
        @info = []
        page_years.each do |page_year|
          if !page_year[:value][:"#{date}"].blank?
            info = []
            info.push(page_year[:_id][:title])
            info.push(page_year[:value][:"#{date}"])
            @info.push(info)
          end
        end
        Kaminari.paginate_array(@info, total_count: @info.size).page(page).per(15)
      end

      def self.paginate_array_article(page_years,page,date)
        @info = []
        page_years.each do |page_year|
          if !page_year[:value][:"#{date}"].blank?
            info = []
            info.push(page_year[:_id][:title])
            info.push(page_year[:value][:"#{date}"])
            @info.push(info)
          end
        end
        Kaminari.paginate_array(@info, total_count: @info.size).page(page).per(15)
      end

      def self.website_visit_stat
        @page_views = Xmt::Stat::PageView.all
      end

    end
  end

end