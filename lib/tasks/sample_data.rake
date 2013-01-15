namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       lab:    "lab-admin",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    lab = "lab-#{n+1}"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 lab:    lab,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do |n|
    title = "Title"
    post_type = "journal"
    publication_name = "Journal #{n+1}"
    month = "1"
    year = "2013"
    content = Faker::Lorem.sentence(5)
    notes = "No notes..."
    users.each { |user| user.microposts.create!(title: title, post_type: post_type, publication_name: publication_name, month: month, year: year, content: content, notes: notes) }
    title = "Title"
    post_type = "conference"
    publication_name = "Conference #{n+1}"
    month = "1"
    year = "2013"
    content = Faker::Lorem.sentence(5)
    notes = "No notes..."
    users.each { |user| user.microposts.create!(title: title, post_type: post_type, publication_name: publication_name, month: month, year: year, content: content, notes: notes) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
