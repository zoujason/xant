class PermissionMgr
  include ::Singleton

  def initialize
    load()
  end

  def load
    @permissions = {}
    Xmt::Rbac::Permission.all.each do |perm|
      perm.privileges.each do |priv|
        k = "#{perm.acopermitable_id.to_s}-#{perm.aropermitable_id.to_s}-#{priv.operation}"
        @permissions[k] = priv.permit if priv.permit == true
      end
    end
  end
  alias reload load

  def permit(aro_id, aco_id, operation)
    k = "#{aco_id.to_s}-#{aro_id.to_s}-#{operation}"
    @permissions[k] == true
  end


end