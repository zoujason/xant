module Xmt
  module Rbac
    class Role
      include ModelBase
      field :name, type: String
      field :sign, type: String
      has_many :permissions, as: :aropermitable, class_name: 'Xmt::Rbac::Permission'
      has_and_belongs_to_many :groups, class_name: 'Xmt::Rbac::Group'

      #
      # def allow(aco_id, operation)
      #   permission = permissions.where(acopermitable_id: aco_id).first
      #   return false unless permission
      #   permission.permit(operation)
      # end

      def allow(aco_id, operation)
        #Waas::Security.authz.permit(self.id,aco_id, operation)
        PermissionMgr.instance.permit(self.id,aco_id, operation)

      end

      def find(aco_id)
        @permits ||= permissions.to_a
        @permits.detect {|perm| perm.acopermitable_id.to_s == aco_id.to_s}
      end
    end

  end
end
