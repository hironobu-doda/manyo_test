# 必要なテーブル一覧
---
- userテーブル
  - name
  - email
  - password_digest

- taskテーブル
  - user_id
  - label_id
  - title
  - content
  - time_limit
  - status

- label
   - label_title


# herokuにデプロイする手順
---
1. heroku create　で新しいアプリケーションを作る
2. rails assets:precompile RAILS_ENV=production　でアセットを事前にコンパイル（実際に実行できる形式に変換）する
3. git add -A
4. git commit -m ""　でコミットする
5. heroku run rails db:migrate　でマイグレーションする
6. git push heroku master　でherokuにデプロイする


# バージョン情報
---
ruby 2.6.0
rails 5.2.2
bundler 1.17.3（bundlerのバージョン2はherokuに対応していません。バージョンダウンしましょう。）
