############################################################
#
#  Name:        Sean Glover
#  Assignment:  Jukebox Assignment
#  Date:        05/06/2013
#  Class:       CIS 283
#  Description: Main file for Jukebox Assignment
#
############################################################

require_relative 'songs_glover.rb'
require_relative 'jukebox_glover.rb'

# method to display menu until user quits
def menu
  puts
  puts "1) Show all songs that are longer than a user entered value"
  puts "2) Show all songs that were written by a specific author"
  puts "3) Play a specific song"
  puts "4) Add a new song to the jukebox from user input"
  puts "5) Delete a song from the jukebox"
  puts "6) Update a song in the jukebox"
  puts "7) Show all songs in the jukebox"
  puts "8) Quit"
end

# method to display update menu - includes additional text if updates are pending
def update_menu(title, artist, album, year, comment, length)
  puts
  puts "1) Song title #{if title != "" then " - pending" end}"
  puts "2) Artist name #{if artist != "" then " - pending" end}"
  puts "3) Album name #{if album != "" then " - pending" end}"
  puts "4) Song Year #{if year != "" then " - pending" end}"
  puts "5) Comment #{if comment != "" then " - pending" end}"
  puts "6) Song Length #{if length != "" then " - pending" end}"
  puts "7) Apply updates"
  puts "8) Cancel All"
end

jukebox = Jukebox.new

# open file and initialize hash
songs_file = File.open("songs_glover.txt")

# loop through file for array population
while ! songs_file.eof?
  # read each line from file
  line = songs_file.gets.chomp

  # split each line on tab
  data_array = line.split("\t")

  # populate array from file of all songs
  #### song title, artist, album, song_year, comments, length in seconds ####
  #songs_array << Songs.new(data_array[0], data_array[1], data_array[2], data_array[3], data_array[4], data_array[5])
  jukebox.add_song(Songs.new(data_array[0], data_array[1], data_array[2], data_array[3], data_array[4], data_array[5]))
end

# close file
songs_file.close

# loop until user exits jukebox
user_option = 0
until user_option == 8
  menu
  user_option = gets.to_i

  if user_option == 1 # show all songs longer than user entered seconds
    print "Enter number to compare song length to: "
    seconds = gets.chomp.to_i

    # condition to validate a number was entered
    if seconds > 0
      puts jukebox.compare_length(seconds)

    else # error message when invalid entry
      puts "That is not a valid song length."
    end

  elsif user_option == 2 # show all songs written by author
    print "Enter artist name to search for: "
    artist = gets.chomp

    # returns results of search for artist
    puts jukebox.find_artist(artist)

  elsif user_option == 3 # play specific song
    puts
    puts jukebox.display_songs
    print "Enter number of song to play: "
    song_option = gets.chomp.to_i

    # condition to validate a number was entered
    if song_option > 0
      puts
      puts jukebox.play(song_option)
    end

  elsif user_option == 4 # add new song to jukebox
    ##### song title, artist, album, song_year, comments, length in seconds ####
    puts
    print "Enter title of new song (leave blank to cancel): "
    title = gets.chomp
    # reused message when record does not get created
    msg = "Record not created."

    # user can exit adding new song at any time by not entering a value
    if title != ""
      print "Enter artists name (leave blank to cancel): "
      artist = gets.chomp

      if artist != ""
        print "Enter album name (leave blank to cancel): "
        album = gets.chomp

        if album != ""
          print "Enter 4 digit song year (leave blank to cancel): "
          song_year = gets.chomp

          if song_year != ""
            if song_year.to_i > 999 and song_year.to_i < 10000
              print "Enter comment for song (leave blank to cancel): "
              comment = gets.chomp

              if comment != ""
                print "Enter length of song in seconds (leave blank to cancel): "
                seconds = gets.chomp

                if seconds != "" and seconds.to_i > 0
                  if seconds.to_i > 0
                    jukebox.add_song(Songs.new(title, artist, album, song_year, comment, seconds))

                  else
                    puts "That is not a valid song length"
                    puts msg
                  end
                else
                  puts msg
                end
              else
                puts msg
              end
            else
              puts "That is not a valid year."
              puts msg
            end
          else
            puts msg
          end
        else
          puts msg
        end
      else
        puts msg
      end
    else
      puts msg
    end

  elsif user_option == 5 # delete song from jukebox
    puts jukebox.display_songs
    puts
    print "Enter number of song to delete: "
    option = gets.to_i

    # condition to validate a number was entered
    if option > 0
      jukebox.delete_song(option)
    else
      puts "That is not a valid option."
    end

  elsif user_option == 6 # update existing song in jukebox
    puts jukebox.display_songs
    puts
    print "Enter number of song to update: "
    song_option = gets.to_i

    # condition to validate a number was entered
    if song_option > 0
      # check to confirm the song choice entered is an existing song
      if jukebox.find_song(song_option)
        new_title = ""
        new_artist = ""
        new_album = ""
        new_year = ""
        new_comment = ""
        new_length = ""

        # loop to stay in update mode until user applies updates or cancels
        update_option = 0
        until update_option == 7 or update_option == 8
          # call update menu - values passed are used to display pending message for each value
          update_menu(new_title, new_artist, new_album, new_year, new_comment, new_length)
          print "Enter your menu option: "
          update_option = gets.chomp.to_i

          if update_option == 1 # update Title of song
            print "Enter new title of song (leave blank to not update): "
            new_title = gets.chomp

          elsif update_option == 2 # update Artist name
            print "Enter new Artist name (leave blank to not update): "
            new_artist = gets.chomp

          elsif update_option == 3 # update Album name
            print "Enter new Album name (leave blank to not update): "
            new_album = gets.chomp

          elsif update_option == 4 # update song year
            print "Enter new 4 digit song year (leave blank to not update): "
            new_year = gets.chomp.to_i

            # validation to verify acceptable year is entered
            if new_year != ""
              if new_year < 999 or new_year > 10000
                puts "That is not a valid song year and will not be added for update."
                new_year = ""
              end
            end

          elsif update_option == 5 # update comment
            print "Enter new comment (leave blank to not update): "
            new_comment = gets.chomp

          elsif update_option == 6 # update song length
            print "Enter new song length in seconds (leave blank to not update): "
            new_length = gets.chomp.to_i

            # validation to verify acceptable song length entered
            if new_length != ""
              if new_length <= 0
                puts "That is not a valid song length and will not be added for update."
              end
            end

          elsif update_option != 7 and update_option != 8
            puts "That is not a valid menu option"
          end
        end

        # apply all song updates
        if update_option == 7
          ##### song title, artist, album, song_year, comments, length in seconds ####
          puts jukebox.update_song(song_option, new_title, new_artist, new_album, new_year, new_comment, new_length)

        else # Cancel All was selected and no updates are applied
          puts "Record was not updated."
        end
      else
        puts "No records found match that criteria."
      end

    else
      puts "That is not a valid song option"
    end

  elsif user_option == 7 # show all songs in jukebox
    puts
    puts jukebox.display_songs

  elsif user_option != 8 # error condition for invalid menu option
    puts "That is not a valid option"
  end
end

# update song file with current jukebox collection
songs_file = File.open("songs_glover.txt", "w")

# write existing songs to file
songs_file.puts jukebox.inventory

songs_file.close
