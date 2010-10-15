require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Tode Ristov",
                 :email => "toderistov@hotmail.com",
                 :password => "Negotino1",
                 :password_confirmation => "Negotino1")
    admin.toggle!(:admin)
    martina = User.create!(:name => "Martina Nikolovska",
                 :email => "martina.nikolovska@hotmail.com",
                 :password => "Negotino1",
                 :password_confirmation => "Negotino1")
    martina.toggle!(:admin)
    20.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@toderistov.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end
