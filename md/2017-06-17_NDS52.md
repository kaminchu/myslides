<!-- $theme: gaia -->

### インターネットの契約から開通まで

2017/06/17 長岡IT開発者勉強会 NDS#52

---

## 誰でも最初にネットが必要
独り暮らし初心者へ捧ぐ  
**それなりに速い**インターネットの契約と開通までの話

---

### 目次
* 回線契約
* ISP契約
* 配線
* ルーターの設定

---

## 回線契約(物理的な確認)
* そもそも光回線が来てるか
* VDSLではないか
    * 最悪、部屋に回線の引き込みが許されるか
    (戸建て契約もできなくはない)  
→ 不動産屋に確認しよう

---

## 回線契約(回線選び)
* NTTフレッツ光がおすすめ  
* 新潟であればNTT東日本  
---

## 回線契約(契約までの流れ)
01. ネット申し込み  
    ※必ずひかり電話(500円くらい/月)も申し込みこと！  
    ※デフォルトでIPv6も使える(NGNのみ)  
02. 電話対応
    * 工事要不要と、日程の打ち合わせ
    * オプション勧誘(無視して大丈夫)
    * 電話番号を3個(?)から選ぶ(ひかり電話の場合)
03. 書類送付
    * 数日後にCAFで始まる番号の書かれた書類が届く

---

## ISP契約(ISP選び)
対応を確認
* **IPoE**なIPv6
* DS-Lite   
→ 個人的にはIIJのFiberAccess/NFプランがおすすめ

---

## なんでDS-Lite?
![DS-Lite](/img/0001.jpg)  
※ゲーム機じゃありません
* メリット
    * 速い
* デメリット
    * NATがISP側になる  

---

## ISP契約(契約までの流れ)
01. NTTから届いたCAFで始まる番号を用意
02. ネットで申し込み
03. 数分でアカウント情報がメールで届く

---

## ルーターの配線
UNI(?)からケーブルを引っこ抜いて、  
空いたポートをルータとつなぐ  
![ここです](/img/0003.jpg)

---

## ルーターの設定
YAMAHAすごい
* DS-Lite対応ルーターを用意
* YAMAHAのRTX1100ならヤフオクにて3000円で買える  
    → 中古でも最新FWに更新できます  
    → YAMAHAすごい

---

## ルーターの設定(DS-Lite)
* DS-Liteの設定(YAMAHA)はこんな感じ

```
ip route default gateway tunnel 1
tunnel select 1
 tunnel encapsulation ipip
 tunnel endpoint address　2404:8e00::feed:101　// NTT東はこのアドレスでつながると思います
 ip tunnel mtu 1500
 ip tunnel tcp mss limit auto
 tunnel enable 1
```

---

## ルーターの設定(IPv6)
* ここでひかり電話の加入が活きる  
    * ひかり電話未加入  
        → LAN内のIPv6アドレスはNGNから  
    * ひかり電話加入  
        → LAN内のIPv6アドレスはルーターで任意
```
ngn type lan2 ntt
ipv6 route default gateway dhcp lan2
ipv6 prefix 1 dhcp-prefix@lan2::/64
ipv6 lan1 address dhcp-prefix@lan2::1/64
ipv6 lan1 rtadv send 1 o_flag=on m_flag=on
ipv6 lan1 dhcp service server
ipv6 lan2 address dhcp
ipv6 lan2 dhcp service client
dns server dhcp lan2
```

---

## ルーターの設定(LAN)
IPv4なLANを構築の設定  

```
ip lan1 address 192.168.100.1/24
dhcp service server
dhcp server rfc2131 compliant except remain-silent
dhcp scope 1 192.168.100.2-192.168.100.199/24
dns server dhcp lan2
```

これで快適インターネット生活が始められる

---

## おおまかな要点(まとめ？)
* NTTフレッツ契約  
    → ひかり電話を契約しよう
* ISP契約  
    → IPoEなIPv6が使えるものを選ぶ  
    → DS-Liteが使えるものを選ぶ  
* ルーター設定    
    → DS-Liteに対応したルータを選ぶ

---

## おまけ
* 実はこのままだと、ひかり電話を契約してるのに電話できない  
    → 機器内のルーター部分を切り離している為
* つなぐと、自ルーターとIPv6を取り合うのでネットに繋がらなくなる
* 機器内のルーターのIPv6パケットをフィルタすればつながるらしい  
    → ためそうにも固定電話持ってなかった・・・

---

## おまけ2
我が家の現状  
![燃えそう](/img/0002.jpg)

---

# おわり

---

# 参考リンク
* NTT申し込み  
    https://flets-ntthikari.jp/form-entry/  

* IIJ申し込み(FiberAccess/NF)  
    https://www.iijmio.jp/cart/estimate/nbd/

* フレッツ光ネクスト (ひかり電話あり) 回線において(略)  
    http://diary.sorah.jp/2017/02/19/flets-ngn-hikaridenwa-kill-dhcpv6pd  



