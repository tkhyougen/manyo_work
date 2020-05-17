server '54.168.7.2', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/c/Users/tomoh/.ssh/id_rsa'
