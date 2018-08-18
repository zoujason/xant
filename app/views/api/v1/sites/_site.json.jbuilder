json.site do
  json.extract! site, :id, :title, :subtitle, :slug, :host, :logo
  json.logo (site.logo.try(:url))
end
