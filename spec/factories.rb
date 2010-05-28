Factory.define(:listing) do |f|
  f.sequence(:title) {|i| "Listing #{i}" }
  f.description "Lorem ipsum dolor sit amet…"
end