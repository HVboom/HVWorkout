# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Rails.env.production?
  # create Demo users
  3.times do |n|
    nickname = "Demo#{n+1}"
    unless User.find_by_nickname(nickname)
      User.create!(nickname: nickname, email: "#{nickname}@HVboom.ch", password: 'Demo2020', password_confirmation: 'Demo2020', confirmed_at: DateTime.now)
      puts "User '#{nickname}' created"
    end
  end
end

