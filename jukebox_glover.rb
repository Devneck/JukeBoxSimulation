############################################################
#
#  Name:        Sean Glover
#  Assignment:  Jukebox Assignment
#  Date:        05/06/2013
#  Class:       CIS 283
#  Description: Class file for jukebox object
#
############################################################

class Jukebox

  def initialize
    @all_songs = []

  end

  def add_song(song)
    @all_songs << song
  end

  def inventory
    ret_str = ""
    @all_songs.each do |song|
      ret_str += song.to_tab + "\n"
    end
    return ret_str.chomp

  end

  def display_songs
    ret_str = "Title                             Artist          Album                          Year       Comment                   Song Length\n"
    @all_songs.each_with_index do |song, index|
      ret_str += "#{index + 1}) #{song.title.ljust(30)} #{song.artist.ljust(15)} #{song.album.ljust(30)} #{song.song_year.ljust(10)} #{song.comment.ljust(25)} #{song.song_length} seconds\n"
    end
    return ret_str
  end

  def delete_song(song_index)
    ret_str = @all_songs[song_index - 1]
    @all_songs.delete_at(song_index - 1)
    return "#{ret_str} has been permanently deleted"
  end

  def compare_length(seconds)
    ret_str = ""
    num = 1
    @all_songs.each do |song|
      if song.song_length.to_i > seconds
        ret_str += "#{num}) #{song.title}\n"
        num += 1
      end
    end
    if ret_str == ""
      ret_str = "No records found that match that criteria"
    end
    return ret_str
  end

  def find_artist(artist)
    ret_str = ""
    num = 1
    @all_songs.each do |song|
      if song.artist == artist
        ret_str += "#{num}) #{song.title}\n"
        num += 1
      end
    end
    if ret_str == ""
      ret_str = "No records found that match that criteria"
    end
    return ret_str
  end

  def play(song_option)
    if @all_songs[song_option - 1] != nil
      return "Now playing #{@all_songs[(song_option - 1)].title}."
    else
      return "No records found match that criteria."
    end
  end

  def find_song(song)
    if @all_songs[song - 1] != nil
      return true
    else
      return false
    end
  end

  def update_song(song, title, artist, album, song_year, comment, song_length)
    ##### song title, artist, album, song_year, comments, length in seconds ####
    ret_str = ""
    song -= 1
    if title != ""
      @all_songs[song].title = title
      ret_str += "Title updated to: #{title}\n"
    end

    if artist != ""
      @all_songs[song].artist = artist
      ret_str += "Artist updated to: #{artist}\n"
    end

    if album != ""
      @all_songs[song].album = album
      ret_str += "Album updated to: #{album}\n"
    end

    if song_year != ""
      @all_songs[song].song_year = song_year
      ret_str += "Year updated to: #{song_year}\n"
    end

    if comment != ""
      @all_songs[song].comment = comment
      ret_str += "Comment updated to: #{comment}\n"
    end

    if song_length != ""
      @all_songs[song].song_length = song_length
      ret_str += "Song length updated to: #{song_length}\n"
    end

    return ret_str
  end

end