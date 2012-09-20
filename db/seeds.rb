load("#{Rails.root}/db/factions.rb")
load("#{Rails.root}/db/maps.rb")

Forum.find_or_create_by(name: "Questions & Answers", description: "If you have any questions regarding Risk 2210 A.D. this is the place to ask.")
Forum.find_or_create_by(name: "General", description: "General discussions regarding Risk 2210 A.D.")
Forum.find_or_create_by(name: "Risk Tracker", description: "Everything about this site.")
Forum.find_or_create_by(name: "Expansions", description: "Anything and everything about Risk 2210 A.D. expansions. Suggest new ones or discuss ideas on improving existing ones.")
