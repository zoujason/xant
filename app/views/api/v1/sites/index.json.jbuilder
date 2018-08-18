json.sites do
  json.array! @sites, partial: 'api/v1/sites/site', as: :site
end
