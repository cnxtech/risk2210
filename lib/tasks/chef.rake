namespace :chef do
  
  desc "Updates chef configuration"
  task :update => :environment do
    system "rsync -r #{Rails.root}/chef ubuntu@risk2210.net:/var/chef"
    system "ssh ubuntu@risk2210.net 'sudo chef-solo -c /var/chef/solo.rb'"
  end

end