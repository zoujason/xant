class SiteMgr
  include ::Singleton
  attr_reader :sites

  def initialize
    self.load()
  end

  def load
    @sites = Xmt::Press::Site.all.to_a
  end

  def find_or_default_by_slug(slug)
    find_by_slug(slug) || self.default
  end

  def find_by_slug(slug)
    @sites.find { |site| site.slug == slug }
  end

  def find_by_id(id)
    @sites.find { |site| site.id.to_s == id.to_s }
  end

  def find_by_parents(parent_ids)
    @sites.find { |site| parent_ids.include?(site.id) }
  end

  def default
    find_by_slug('www') || @sites.first
  end

end