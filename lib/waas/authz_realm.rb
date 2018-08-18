module Waas
  class AuthzRealm

    def initialize
      @permissions = {}
    end

    def permit(aro_id, aco_id, operation)
      k = "#{aco_id}-#{aco_id}"
      #@permissions[k] ||= Xmt::Rbac::Permission.where(aropermitable_id: aro_id, acopermitable_id: aco_id).first
      #perm = @permissions[k]
      perm = Xmt::Rbac::Permission.where(aropermitable_id: aro_id, acopermitable_id: aco_id).first
      return perm.permit(operation) if perm
      return false
    end

    def authorize(principal)
      user = Xmt::Staff::User.find_by_principal(principal)
      info = AuthzInfo.new(user.roles)
      user.groups.each do |group|
        info.roles |= group.roles
      end
      info
    end

  end
end
