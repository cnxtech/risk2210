package "git-core"

include_recipe "apt"
include_recipe "mongodb::10gen_repo"
include_recipe "mongodb::default"
include_recipe "passenger::daemon"

user node[:user][:name] do
  password node[:user][:password]
  gid "admin"
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
end