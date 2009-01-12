Factory.define(:listing) do |f|
  f.sequence(:title) {|i| "Listing #{i}" }
  f.description "Lorem ipsum dolor sit amet…"
  f.duration 3
  f.created_at Time.zone.now
  f.end_at 3.days.from_now
  f.association :user
end

Factory.define(:bid) do |f|
  f.association :user
  f.association :listing
  f.amount "$1.00"
end