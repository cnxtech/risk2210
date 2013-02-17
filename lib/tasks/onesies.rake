namespace :onesies do

  task :set_space_stations => :environment do

    Faction.all.each do |faction|
      if ["Church of Him", "Free Militia"].include?(faction.name)
        faction.update_attribute(:space_stations, 0)
      elsif ["Gayans", "Preservation"].include?(faction.name)
        faction.update_attribute(:space_stations, 2)
      else
        faction.update_attribute(:space_stations, 1)
      end

      if faction.name == "MegaCorp"
        faction.update_attribute(:starting_resources, "4 Energy\nLand Commander\n1 Space Station")
      end
    end

  end

end
