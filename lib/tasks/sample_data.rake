require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do

    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
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
end

def make_microposts
  User.all(:limit => 6).each do |user|
    10.times do
      content = Faker::Lorem.sentence()
      puts content
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all()
  user = users.first
  following = users[1..10]
  followers = users[5..15]
  following.each{
    |followed|
    user.follow!(followed)
  }
  followers.each{
    |follower|
    follower.follow!(user)
  }
end

