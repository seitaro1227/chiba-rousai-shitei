# 千葉の労災指定医療機関を探す
## このWebサービスについて
[労災保険指定医療機関等（千葉県内）](http://chiba-roudoukyoku.jsite.mhlw.go.jp/hourei_seido_tetsuzuki/rousai_hoken/hourei_seido/iryou2011.html)
の指定医療機関名簿のデータを地図上に落とし込み、病院名や診療科目や現在地の検索できるようにしたWebサービスです。

## デモ


## 機能
- 監督署、病院名、診療科目、現在地からの距離での絞込ができます。

## Todo
- ブックマーク機能
- 比較機能
- 診療科目のカラムを正規化する
- leaflet.jsを導入する
- 位置情報をロード時に取得する
- 距離の絞込をjsで完結させる

## データの作成
### 初めてデータを登録する
`data/hospital.xlsx`からDBにデータ登録し、住所から位置情報を取得し登録します。
```
rake db:migrate
rake db:seed_fu
rake geocoder:hospital:update
```

### 位置情報の取得に失敗したデータを確認する
位置情報の取得に失敗したデータを探します。
```
rake geocoder:hospital:not_geocoded_list
```

病院の施設名から位置情報を探します。
```
rake geocoder:hospital:update_by_names
```

取得に失敗した位置情報は`rails console`から自力で登録してください。

### データを更新する
`data/hospital.xlsx`からDBにデータ登録し、住所から位置情報を取得し登録します。
```
rake db:reset
rake db:migrate
rake db:seed_fu
rake geocoder:hospital:import
rake geocoder:hospital:update
```
位置情報の取得に失敗したデータを確認する手順を再度実施します。

### 使用ライブラリ
Rails 5.0.1
jQuery
Google Maps JavaScript API V3