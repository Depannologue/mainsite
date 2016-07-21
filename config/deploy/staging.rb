server '139.59.145.243', user: 'deploy', roles: %w{app db web}, primary: true
set :rails_env, :staging
