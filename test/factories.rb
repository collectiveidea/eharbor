Factory.define :listing do |f|
  f.title "Tickle Me Elmo"
  f.description "You can tickle him!"
  f.duration 3
end

Factory.define :user do |f|
  f.sequence(:email) {|n| "user#{n}@example.com"}
  f.password 'password'
  f.password_confirmation {|user| user.password }
end