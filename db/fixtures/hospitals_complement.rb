# Hospital.find_by(number: '1232231').update(latitude: 35.840041, longitude: 139.967815) # name: '医療法人社団優仁会 新柏ファミリー歯科'
# Hospital.find_by(number: '1232444').update(latitude: 35.843758, longitude: 139.954689) # name: 'ひろクリニック'
# keys = [:jurisdiction, :number, :name, :zip_code, :orgin_address, :subject, :saikei, :niji, :phone_number]
# cells = ["成田", "1281097", "医療法人社団昭文会 黒田内科診療所", "286-0036", "成田市加良部１－３－２", "内・形",nil,nil, "0476-26-3251"]
# values = [keys, cells].transpose.to_h
# values[:address] = values[:orgin_address]
# Hospital.seed(:number, values)