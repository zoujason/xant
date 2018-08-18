module Xmt
  module Rbac
    class Permission
      include ModelBase

      embeds_many :privileges
      belongs_to :aropermitable, polymorphic: true
      belongs_to :acopermitable, polymorphic: true

      def self.permit(aro_id, aco_id, operation)
        begin
          perm  ||=  Permission.find_by(aropermitable_id: BSON::ObjectId(aro_id), acopermitable_id: BSON::ObjectId(aco_id))
        rescue
          return false
        end
        perm.permit(operation)
      end

      def permit(operation)
        privileges.any? {|priv| priv.operation.to_s == operation.to_s && priv.permit.to_s == 'true'}
      end

      def api
        print "well"
      end

    end
  end
end
