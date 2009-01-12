Gem::Specification.new do |s|
  s.name = 'money'
  s.version = '1.7.3'
  s.summary = "Class aiding in the handling of Money."
  s.description = 'Class aiding in the handling of Money and Currencies. It supports easy pluggable bank objects for customized exchange strategies. Can be used as composite in ActiveRecord tables.'
  s.has_rdoc = true

  s.files = %w(
    README
    MIT-LICENSE
    lib/money.rb
    lib/money/core_extensions.rb
    lib/money/bank/no_exchange_bank.rb
    lib/money/bank/variable_exchange_bank.rb
    lib/money/rails.rb
    lib/support/cattr_accessor.rb
  )

  s.require_path = 'lib'
  s.author = "Tobias Luetke"
  s.email = "tobi@leetsoft.com"
  s.homepage = "http://leetsoft.com/rails/money"  
end
