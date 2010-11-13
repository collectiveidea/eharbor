FactoryGirl.define do
  factory :listing do
    title "Tickle Me Elmo"
    description "You can tickle him!"
    duration 3
  end

  factory :user do
    sequence(:email) {|n| "user#{n}@example.com"}
    password 'password'
    password_confirmation {|user| user.password }
  end
end