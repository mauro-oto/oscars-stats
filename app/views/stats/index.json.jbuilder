json.array!(@stats) do |stat|
  json.extract! stat, :id
  json.url stat_url(stat, format: :json)
end
