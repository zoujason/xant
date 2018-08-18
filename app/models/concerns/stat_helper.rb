module StatHelper
  module PageStat

    def pages_per_author(option='')
      default = option.blank? ? "$author" : option
      pipeline = [
          # {"$match": {
          #         "created_at": {
          #             "$gte":   dt.at_beginning_of_month,
          #             "$lte":  dt.at_end_of_month
          #         }
          #     }},
          {
              "$group": {
                  _id: {author: default},
                  matches: { "$sum": 1 }
              }
          }]
      self.collection.aggregate(pipeline)
    end

    def pages_per_dept(option='')
      default = option.blank? ? "$dept_id" : option
      pipeline = [
          {"$group": {
              _id: {dept_id: default},
              matches: { "$sum": 1 }}
          }
      ]
      self.collection.aggregate(pipeline)
    end


  end
end