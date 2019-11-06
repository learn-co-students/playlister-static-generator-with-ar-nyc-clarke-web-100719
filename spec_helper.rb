ENV["PLAYLISTER_ENV"] = "test"

require_relative '../config/environment'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.color = true
  config.formatter = :documentation
  config.order = 'default'

  config.before do
    reset_database
  end
end

def reset_database
  migrate_db
end

def clean_database
  Artist.delete_all if defined?(Artist) && DB.tables.include?("artists")
  Song.delete_all if defined?(Song) && DB.tables.include?("songs")
  Genre.delete_all if defined?(Genre) && DB.tables.include?("genres")
end

def seed_database
  LibraryParser.new('spec/fixtures/mp3s').parse_and_insert_songs
end
