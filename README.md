# 千葉の労災指定医療機関を探す
## このWebサービスについて
[労災保険指定医療機関等（千葉県内）](http://chiba-roudoukyoku.jsite.mhlw.go.jp/hourei_seido_tetsuzuki/rousai_hoken/hourei_seido/iryou2011.html)
の指定医療機関名簿のデータを地図上に落とし込み、病院名や診療科目や現在地の検索できるようにしたWebサービスです。

## デモ
https://chiba-rousai-shitei.herokuapp.com/

## 機能
- 監督署、病院名、診療科目、現在地からの距離での絞込ができます。
- admin画面から病院の情報を訂正できます。

## Todo
- ブックマーク機能
- 比較機能

## データを登録する
`data/hospital.csv`からDBにデータ登録します
```
bin/rake db:migrate
bin/rake db:seed_fu
```

## 位置情報を登録する
住所から位置情報を取得し登録します
```
bin/rake geocode:all CLASS=Hospital SLEEP=0.25
bin/rake geocode:all CLASS=Station SLEEP=0.25
```

### 使用ライブラリ
Rails 5.0.1
jQuery
Leaflet.js