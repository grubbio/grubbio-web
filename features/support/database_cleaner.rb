truncation_exceptions = %w[
  markets
  food_products
]

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
  # { :except => [:widgets] } may not do what you expect here
  # as Cucumber::Rails::Database.javascript_strategy overrides
  # this setting.
  DatabaseCleaner.strategy = :truncation, { :except => truncation_exceptions }
end

Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
  DatabaseCleaner.strategy = :transaction
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation, { :except => truncation_exceptions }

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end