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


Herokuへのデプロイ

　アセットプリコンパイルを行う
  $ rails assets:precompile RAILS_ENV=production
  masterへpush
  $ git add -A
  $ git commit -m "test commit"

  $  heroku buildpacks:add --index 1 heroku/nodejs

  $ git push heroku master
