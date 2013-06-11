namespace :db do
  desc "Fill database with sample data users"
  task users: :environment do
    User.create!(email: "example@mqe.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    50.times do |n|
      email = "example-#{n+1}@mqe.com"
      password  = "password"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end