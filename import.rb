# Account #1
Import::Teller.new(
  ENV['TELLER_TOKEN'],
  "f38c26fc-29af-4087-875b-030bc3765936",
  "14d7e25f-0d8f-4a16-b2a4-1383174f4737"
).import

# Account #2
Import::Teller.new(
  ENV['TELLER_TOKEN'],
  "54aeeef5-0dfa-4af0-b714-9af78ed27c79",
  "0eba281d-3e10-4e43-be83-3187a3cf1e9b"
).import
