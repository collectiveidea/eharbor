Factory.sequence(:title) {|i| "Listing #{i}" }
Factory.define :listing do |l|
  l.title { Factory.next(:title) }
  l.description 'Lorem ipsum dolor sit amet…'
  l.duration 5
  l.association :user
end

Factory.sequence(:bid_amount) {|i| i.to_money }
Factory.define :bid do |b|
  b.amount { Factory.next(:bid_amount) }
  b.association :listing
  b.association :user
end