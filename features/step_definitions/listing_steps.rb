Given 'a listing exists with a title of "$title"' do |title|
  FactoryGirl.create(:listing, :title => title)
end