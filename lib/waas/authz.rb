module Waas
  class Authz

    def initialize
      @realm = AuthzRealm.new()
    end

    def permit(aro_id, aco_id, operation)
      @realm.permit(aro_id, aco_id, operation)
    end

    def approve(principal)
      @realm.authorize(principal)
    end

  end
end
