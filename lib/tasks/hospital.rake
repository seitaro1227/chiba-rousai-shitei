require 'roo'
require 'yaml'
namespace :geocoder do
  namespace :hospital do

    desc "病院の住所から位置情報の取得し更新します。"
    task :update => :environment do
      hospitals = Hospital.not_geocoded
      puts "位置情報が登録されていない病院は#{hospitals.count}件"
      puts '登録開始'
      hospitals.find_each do |h|
        puts "#{h.name}"
        h.geocode
        h.save
      end
      puts '登録完了'
    end

    desc "病院の住所から位置情報の取得に失敗した一覧を表示します"
    task :not_geocoded_list => :environment do
      Hospital.not_geocoded.each do |h|
        puts "Hospital.find_by(number: '#{h.number}').update(latitude: #{h.latitude}, longitude: #{h.longitude}) # name: '#{h.name}'"
      end
    end

    desc "施設名から位置情報を探す"
    task :update_by_names => :environment do
      Hospital.not_geocoded.each do |h|
        name = h.name.gsub(/(\r\n|\r|\n)/, '')
        search_result = Hospital.find_by(number: '1224425')
        unless search_result.empty? || search_result.size > 2
          result = search_result.first
          if h.zip_code == result.postal_code
            h.update(latitude: result.latitude, longitude: result.longitude)
          else
            puts "skip: #{name}"
            puts "zip_code_differed"
            puts "h.zip_code: #{h.zip_code}, result.postal_code: #{result.postal_code}"
          end
          puts "name: #{name}"
          puts "lat: #{result.latitude},lng: #{result.longitude}"
          puts "address: #{result.address}"
        else
          puts "skip: #{name}"
        end
        puts "----------------------------------"
      end
    end

    desc "位置情報の取得に成功した病院をdata/hospital_geo.yamlに書き出します"
    task :export => :environment do
      data = {}
      Hospital.geocoded.each do |h|
        data[h.number] = {name: h.name,
                          latitude: h.latitude,
                          longitude: h.longitude}
      end
      open("./data/hospital_geo.yaml","w") do |f|
        YAML.dump(data,f)
      end
    end

    desc "取得に失敗した病院をdata/hospital_not_geocoded.yamlに書き出します"
    task :export_not_geocoded => :environment do
      data = {}
      Hospital.not_geocoded.each do |h|
        data[h.number] = {name: h.name,
                          latitude: h.latitude,
                          longitude: h.longitude}
      end
      open("./data/hospital_not_geocoded.yaml","w") do |f|
        YAML.dump(data,f)
      end
    end

    desc "病院の位置情報をdata/hospital_geo.yamlから取り込みます"
    task :import => :environment  do
      data = YAML.load_file("./data/hospital_geo.yaml")
      data.each do|number, values|
        name = values.delete(:name)
        if(hospital = Hospital.find_by(number: number))
          hospital.update(values)
        else
          puts "番号#{number}の病院#{name}は登録されていません。"
        end
      end
    end
  end
end

