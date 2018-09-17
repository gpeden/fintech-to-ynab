# Account #1
Import::Teller.new(
  ENV['TELLER_TOKEN'],
  ENV['TELLER_ACCOUNT_ID1'],
  ENV['YNAB_ACCOUNT_ID1']
).import
