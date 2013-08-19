object @match
  attributes :id
  node(:delete_url) { |match| match_path(match) }
  node(:edit_url) { |match| edit_match_path(match) }

child local: :local do
  attributes :id, :name
  node(:url) { |local| team_path(local) }
end

child visitor: :visitor do
  attributes :id, :name
  node(:url) { |visitor| team_path(visitor) }
end

child reservation: :reservation do
  attributes :reservation_date
  child :field do
    attributes :id, :name
    node(:url) { |field| location_field_path(field.location, field) }
  end
end
