namespace :onesies do

  task :fix_slugs => :environment do
    [Map, Continent, Faction, Player, Forum, Topic].each do |klass|
      klass.all.each { |u| u._slugs = [u.attributes["slug"]] unless u.attributes["slug"].nil? ; u.save ; u.unset(:slug) unless u.attributes["slug"].nil? }
    end
  end

end
