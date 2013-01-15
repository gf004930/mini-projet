FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    sequence(:lab)  { |n| "Lab #{n}" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    title "Title"
    post_type "journal"
    sequence(:publication_name)  { |n| "Publication #{n}" }
    month "1"
    year "2013"
    content "Lorem ipsum"
    user
  end
end
