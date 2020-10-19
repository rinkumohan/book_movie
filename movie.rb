require_relative "book_movie"

#Program begins here
begin
  BookMovie.new.book_tickets_for_user
rescue => e
    binding.pry
  puts "Something went wrong!"
end