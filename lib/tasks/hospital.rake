if Rails.env == 'development'
  require 'roo'
  require 'yaml'
  require 'uri'

  XLSX_URI    = 'http://chiba-roudoukyoku.jsite.mhlw.go.jp/var/rev0/0109/5547/iryou01.2905.xlsx'
  COLUMN_NAME = [
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

  def row_gsub(row)
    row.to_a.map do |column|
      # 改行を消す
      # ¥tや全角スペースを半角スペースに揃える
      # 連続するスペースを半角スペース1に寄せる
      if column.is_a? String
        column.gsub!(/(\r\n|\r|\n)/, '')
        column.gsub!(/[\t　]/, ' ')
        column.gsub!(/\s+/, ' ')
      end
      column
    end
  end

  namespace :hospital do
    desc "./data/org/hospital.xlsx を再取得し ./data/hospital.csv を作成します"
    task :reset_csv => :environment do
      mkdir_p './data/org/'
      Rake::Task['hospital:fetch_xlsx'].execute
      Rake::Task['hospital:create_csv'].execute
    end

    desc "./data/org/hospital.xlsx から ./data/hospital.csv を作成します"
    task :create_csv => :environment do
      sheet = Roo::Spreadsheet.open('./data/org/hospital.xlsx').sheet(0)
      rows  = sheet.to_matrix.row_vectors[3..-1]
      rows  = rows.map{|row| row_gsub(row)}
      CSV.open('./data/hospital.csv', "wb") do |csv|
        rows.each do |row|
          csv << row
        end
      end
    end

    desc "./data/org/hospital.xlsxをダウンロードします"
    task :fetch_xlsx => :environment do
      rm './data/org/hospital.xlsx', :force => true
      uri = URI.parse(XLSX_URI)
      Net::HTTP.start(uri.host) do |http|
        resp = http.get(uri.path)
        open("./data/org/hospital.xlsx", "wb") { |file| file.write(resp.body) }
      end
    end
  end
end