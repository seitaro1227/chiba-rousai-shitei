station_names = %w"松戸駅 千葉駅 柏駅 船橋駅 茂原駅 東金駅 銚子駅 成田駅 木更津駅"

station_names.each_with_index do |station_name , index|
  Station.seed(:id) do |s|
    s.id= index
    s.name= station_name
  end
end