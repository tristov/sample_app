# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Tode Ristov"
  user.email                 "toderistov@hotmail.com"
  user.password              "flipflop"
  user.password_confirmation "flipflop"
end
