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

## アセットプリコンパイルを行う
`$ rails assets:precompile RAILS_ENV=production'`

## Masterへpush
`$ git add -A`
`$ git commit -m "test commit" `
`$ git push heroku master`

### エラーが出た場合
`$  heroku buildpacks:add --index 1 heroku/nodejs`

## データベースMigrate
`$ heroku run rails db:migrate`

### アドレス確認
`$ heroku config`
