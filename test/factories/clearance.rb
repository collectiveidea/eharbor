Factory.sequence :nickname do |n|
  "user#{n}"
end

Factory.define :user do |user|
  user.nickname              { Factory.next :nickname }
  user.email                 {|u| "#{u.nickname}@example.com" }
  user.password              { "password" }
  user.password_confirmation { "password" }
  user.email_confirmed { true }
end
