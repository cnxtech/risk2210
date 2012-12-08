namespace :onesies do

  desc "Populates handle on all old game_player records"
  task :populate_game_player_handles => :environment do
    GamePlayer.all.each do |game_player|
      if game_player.player.nil?
        game_player.game.try(:destroy)
      else
        game_player.update_attribute(:handle, game_player.player.handle)
      end
    end
  end

  desc "Update continent Lava continents to Water continents"
  task :update_lava => :environment do
    Continent.where(type: "Lava").update_all(type: "Water")
  end

end
