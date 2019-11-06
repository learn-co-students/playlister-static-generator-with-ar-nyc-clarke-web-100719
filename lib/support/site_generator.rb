require 'fileutils'

class SiteGenerator

    attr_accessor :rendered_path

    def initialize(path)
        self.rendered_path = path
        FileUtils::mkdir_p path
        FileUtils::mkdir_p "#{path}/songs"
        FileUtils::mkdir_p "#{path}/artists"
        FileUtils::mkdir_p "#{path}/genres"
    end

    def build_index
        @template = File.read('./app/views/index.html.erb')
        erb = ERB.new(@template)
        File.open("#{self.rendered_path}/index.html", "w+") do |f|
            f << erb.result(binding)
        end
    end

    def build_artists_index
        @template = File.read('./app/views/artists/index.html.erb')
        erb = ERB.new(@template)
        File.open("#{self.rendered_path}/artists/index.html", "w+") do |f|
            @artists = Artist.all
            f << erb.result(binding)
        end
    end

    def build_genres_index
        @template = File.read('./app/views/genres/index.html.erb')
        erb = ERB.new(@template)
        File.open("#{self.rendered_path}/genres/index.html", "w+") do |f|
            @genres = Genre.all
            f << erb.result(binding)
        end
    end

    def build_songs_index
        @template = File.read('./app/views/songs/index.html.erb')
        erb = ERB.new(@template)
        File.open("#{self.rendered_path}/songs/index.html", "w+") do |f|
            @songs = Song.all
            f << erb.result(binding)
        end
    end

    def build_artist_page
        Artist.all.each do |artist|
            @template = File.read('./app/views/artists/show.html.erb')
            erb = ERB.new(@template)
            File.open("#{self.rendered_path}/artists/#{artist.to_slug}.html", "w+") do |f|
                @artist = artist
                @genres = @artist.genres
                @songs = @artist.songs
                f << erb.result(binding)
            end
        end
    end

    def build_genre_page
        Genre.all.each do |genre|
            @template = File.read('./app/views/genres/show.html.erb')
            erb = ERB.new(@template)
            File.open("#{self.rendered_path}/genres/#{genre.to_slug}.html", "w+") do |f|
                @genre = genre
                @artists = @genre.artists
                @songs = @genre.songs
                f << erb.result(binding)
            end
        end
    end


    def build_song_page
        Song.all.each do |song|
            @template = File.read('./app/views/songs/show.html.erb')
            erb = ERB.new(@template)
            File.open("#{self.rendered_path}/songs/#{song.to_slug}.html", "w+") do |f|
                @song = song
                f << erb.result(binding)
            end
        end
    end

end