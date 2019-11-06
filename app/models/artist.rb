class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def to_slug
    self.name.downcase.gsub(" ", "-")
  end

end