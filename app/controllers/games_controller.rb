require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    arr_letters = Array('A'..'Z')
    @letters = Array.new(10) { arr_letters.sample }
  end

  def score
    @word = params[:word]
    @word_splitted = @word.upcase.split('')
    @letters = params[:letters]
    @letters_splitted = @letters.split('')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    api = open(url).read
    @result = JSON.parse(api)
    @result["found"] ? (@answer_b = 'and is an english word !') : (@answer_b = 'and is not an english word !')

    @word_splitted.each do |letter_w|
      if @letters_splitted.include?(letter_w) # && @result["found"]
        @answer = 'The word matchs the list !'
      else
        @answer = "Sorry but #{@word} can't be build out of #{@letters_splitted.join('')}"
      end
    end
  end
end
