# "./data/hospital.xlsxからデータを取り込みます"
require 'csv'

KEYS = [
    :jurisdiction_id, # "監督署"
    :number, # "番号"
    :name, # "名　　　　　　　称"
    :zip_code, # "〒"
    :orgin_address, # "所　　　在　　　地"
    :orgin_subject, # "診療科目"
    :saikei, # "採型"
    :niji, # "二次"
    :phone_number # "電 話"
]

CSV.foreach('./data/hospital.csv') do |row|
  values = [KEYS, row].transpose.to_h
  Hospital.seed(:number, values)
end
