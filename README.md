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
#### GithubにPushしたら自動デプロイについて
https://reasonable-code.com/github-push-heroku/
#### ローカルを最新に
`git checkout master`
`git pull origin master`
