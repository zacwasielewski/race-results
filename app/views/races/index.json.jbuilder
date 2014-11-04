json.array!(@races) do |race|
  json.extract! race, :id, :name, :date
  json.url race_url(race, format: :json)
end
