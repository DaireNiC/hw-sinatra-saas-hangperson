class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  # instance variabes
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  # display word with missing chars
   def word_with_guesses
    
  if @guesses.empty?
     return @word.gsub(/./, '-') 
   end

    # swap all chars from guesses array with - 
   @word.gsub(/[^#{@guesses}]/, '-')
    
  end
  
  # check for 7 incorect guesses or correct word guess
  def check_win_or_lose
    
    return :lose if @wrong_guesses.length == 7

    return @word.length then :win
      else :play end
  end
  
  # User guesses a letter
  def guess(char)
   #raise error if letter is null or guess is not alphabetic char
  # src: https://stackoverflow.com/questions/6067592/regular-expression-to-match-only-alphabetic-characters
    raise ArgumentError if char.nil? or not char.match(/^[A-Za-z]+$/)
    
    # convert letter to lowercase
    char.downcase!
    
    #check if the letter is in the word and not guessed already
    if @word.include? char and not @guesses.include? char
      # add the char to the guesses
      @guesses << char
      return true
    # otherwise user guessed an incorrect letter 
    # char isnt in the word
    elsif not @word.include? char 
      # and it hasnt been guesssed before
      if not @wrong_guesses.include? char
      # add it to incorrect guesses
        @wrong_guesses << char
        return true
      end
    end
    
      return false
  end
end
