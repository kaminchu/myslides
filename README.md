# myslides

## 説明
勉強会での発表資料置き場

## 見れる場所
https://gitpitch.com/kaminchu/myslides  


## 運用
01. 発表したい資料のファイル名を`package.json`の`script`にある`build`に書く  
02. ターミナルで`npm run build`を叩くと`PITCHME.md`が直下に生成or上書きされる  
03. ターミナルで`npm run test`を叩くとtextlintなどで文書がチェックされる  