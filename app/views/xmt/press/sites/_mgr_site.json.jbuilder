json.extract! mgr_site, :id, :title, :host, :slug, :tpl, :created_at, :updated_at
json.url mgr_site_url(mgr_site, format: :json)