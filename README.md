ログイン画面を実装しましょう
ログインしていないのにタスク一覧のページに飛ぼうとした場合は、ログインページに遷移させましょう
自分が作成したタスクだけを表示するようにしましょう
ログアウト機能を実装しましょう
今回は、ユーザの登録（new）画面と、詳細・マイページ（show）画面のみを作成しましょう
ユーザ登録（create）をした時、同時にログインもさせるようにしましょう
ログインしている時は、ユーザ登録画面（new画面）に行かせないように、コントローラで制御しましょう
自分（current_user）以外のユーザのマイページ（userのshow画面）にアクセスしたらタスク一覧に遷移させるようにしましょう


User
  id
  name:string
  email:string
  password


Task
  id
  user_id
  name:string  :null
  detail:text  :null
  due:date  :null
  priority:integer  
  status:integer   
  label:string   





# Herokuへのデプロイ

##yarn install （必要であれば）
## Masterへpush
`$ git add -A`
`$ git commit -m "test commit"`  
`$ git push origin ブランチ名or master `

## Herokuにて新しくアプリ作成 (初回)
`$ heroku create `

## git hub　マージ
`git hub上にてプルリクエスト、OKならmasterへ
マージ`

## Heokuへのデプロイ
`$ git push heroku master `

## データベース移行(データベースの移行　マイグレーション必要な場合)
`$ heroku run rails db:migrate`

### 以下参考
#### エラーが出た場合
`$  heroku buildpacks:add --index 1 heroku/nodejs`
#### アドレス確認
`$ heroku config`
https://damp-atoll-65761.herokuapp.com/
#### GithubにPushしたら自動デプロイについて
https://reasonable-code.com/github-push-heroku/
#### masterにマージしたらローカルを最新masterに
`git checkout master`
`git pull origin master`
