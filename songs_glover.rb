############################################################
#
#  Name:        Sean Glover
#  Assignment:  Jukebox Assignment
#  Date:        05/06/2013
#  Class:       CIS 283
#  Description: Class file for songs object
#
############################################################

class Songs
  attr_accessor :comment, :title, :artist, :album, :song_year, :song_length

  def initialize(title, artist, album, song_year, comment, song_length)
    @title = title
    @artist = artist
    @album = album
    @song_year = song_year
    @comment = comment
    @song_length = song_length
  end

  def to_tab
    return "#{@title}\t#{@artist}\t#{@album}\t#{@song_year}\t#{@comment}\t#{@song_length}"
  end

end