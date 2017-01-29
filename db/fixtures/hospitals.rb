# "./data/hospital.xlsxからデータを取り込みます"
keys = [
    :jurisdiction, # "監督署"
    :number, # "番号"
    :name, # "名　　　　　　　称"
    :zip_code, # "〒"
    :orgin_address, # "所　　　在　　　地"
    :subject, # "診療科目"
    :saikei, # "採型"
    :niji, # "二次"
    :phone_number # "電 話"
]

errors = StringIO.new('','r+')
sheet = Roo::Spreadsheet.open('./data/hospitals.xlsx').sheet(0)
sheet.each_row_streaming(offset: 3) do |row|
  break if row.map(&:cell_value)[1].nil?
  cells = row.map(&:cell_value)
  unless cells.count == keys.size
    errors.puts "セルのsizeが足りません.(自力で登録してください)"
    errors.puts keys.to_s
    errors.puts cells.to_s
    next
  end
  values = [keys, cells].transpose.to_h
  values[:address] = values[:orgin_address]
  Hospital.seed(:number, values)
end

puts "bin/rake geocode:all CLASS=Hospital で緯度経度を更新してください。"
puts "エラー¥n#{errors.string}" unless errors.blank?