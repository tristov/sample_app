# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Tode Ristov"
  user.email                 "toderistov@hotmail.com"
  user.password              "Negotino1"
  user.password_confirmation "Negotino1"
end

Factory.sequence(:email) { |n|  "person-#{n}@toderistov.com"}

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end
