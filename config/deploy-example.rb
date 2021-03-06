set :application, "columnlog"
set :scm, :git
set :repository, "git://github.com/quirkey/columnlog.git"
set :branch, 'master'
set :git_enable_submodules, 1
set :keep_releases, 3
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :monit_group, 'my_monit_group'

server "myserver.net", :web, :app, :db, :primary => true


namespace :deploy do
  task :restart do
    monit.restart
  end  
end

namespace :monit do
  task :restart do
    sudo "monit restart -g #{monit_group} all"
  end
end


namespace :columnlog do
  
  task :link_columns do
    run "mkdir -p #{shared_path}/data"
    run "ln -nfs #{shared_path}/data/columns.yml #{release_path}/config/columns.yml"
  end
  
end

after "deploy:update_code", "columnlog:link_columns"