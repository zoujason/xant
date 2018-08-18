class DomainConstraint
  def initialize

  end

  def matches?(request)
    SiteMgr.instance.sites.each do |site|
      if site.host == request.host || site.slug == request.subdomain || site.slug == request.path_parameters[:slug]
        request.query_parameters[:slug] = site.slug
        return true
      end
    end
    false
  end
end