object @match
  attributes :id

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
