100.times { FactoryGirl.create(:campaign) }

puts Cowsay.say "Generated 100 campaigns!"
