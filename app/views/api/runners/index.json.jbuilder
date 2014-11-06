json.array!(@runners) do |runner|
  json.extract! runner, :id, :name, :place, :sex, :place_in_sex, :place_in_age_group, :age_group, :gun_time, :gun_pace, :net_time, :net_pace, :country, :state
  json.url race_runner_url(@race, runner, format: :json)
end
