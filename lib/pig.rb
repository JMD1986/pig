require_relative '../db/setup.rb'
require_relative './player.rb'
require_relative './leaderboard.rb'

class Pig
  def initialize
    @players   = []
    @max_score = 100
  end

  def get_players
    puts "Getting player names. Type q when done."
    player_information = Leaderboard.find(2)
    player_information.names= @players.name
    player_information.games_won = 4
    player_information.game_lost = 2
    player_information.save

    loop do
      print "Player #{@players.count + 1}, what is your name? > "
      input = gets.chomp
      if input == "q" || input == ""
        return nil
      else
        @players.push Player.new(input)
      end
    end
  end

  def play_round
    @players.each do |p|
      puts "\n\nIt is #{p.name}'s turn! You have #{p.score} points. (Press ENTER)"
      gets
      take_turn p
    end
    remove_losing_players!
  end

  def remove_losing_players!
    if @players.any? { |p| p.score > @max_score }
      max_score = @players.map { |p| p.score }.max
      @players = @players.select { |p| p.score == max_score }
    end
  end

  def winner
    if @players.length == 1
      @players.first
    end
  end

  def print_leaderboard
    print "would you like to know the current player scores? (y/n) > "
    answer = gets.chomp
    if answer.downcase == "y"
      print #method for printing out several rows of table
    elsif answer.downcase == "n"
      print "not very curious are we?"
    else break
  end

  def take_turn player
    turn_total = 0
    loop do
      roll = rand 1..6
      if roll == 1
        puts "You rolled a 1. No points for you!"
        return
      else
        turn_total += roll
        puts "You rolled a #{roll}. Turn total is #{turn_total}. Again?"
        if gets.chomp.downcase == "n"
          puts "Stopping with #{turn_total} for the turn."
          player.score += turn_total
          return
        end
      end
    end
  end
end
