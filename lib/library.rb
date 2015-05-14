require "lib_gem/version"
require "library/author"
require "library/book"
require "library/reader"
require "library/order"

module Library
  class Library
	  attr_reader :authors, :books, :orders, :readers

	   def initialize
	    @authors, @books, @orders, @readers = [], [], [], []
	   end

	  def add_order(order)
	    @orders.push order
	    @books.push order.book
	    @authors.push order.book.author
	    @readers.push order.reader
	  end

	  def most_popular_book
	    return if orders.empty?
	    books = self.orders.map { |order| order.book }
	    count(books).max_by{ |key, value| value }.first
	  end

	  def often_takes_the_book(book)
	    return if orders.empty?
	    orders =  self.orders.select{ |order| order.book == book }
	    count(orders.map(&:reader)).max_by{ |key, value| value }.first
	  end

	  def how_many_people_ordered_one_of_three_most_popular_books
	    return [] if orders.empty?
	    count(orders.map(&:book)).sort_by(&:last).reverse![0..2]
	  end


	  def save_to_file
	    File.open("library.txt", "w") do |f|
	    	@orders.each { |i| f.puts "#{i.reader}: #{i.book} #{i.date}"}	
	    end
	  end


	  def read_from_file
	      item_fields = File.readlines("library.txt")
	  end


	  private

	  def count(items)
	    items.inject(Hash.new 0) { |hash, item| hash[item] += 1; hash }
	  end

  end
end

=begin
  library = Library.new
  
  alexander = Author.new 'Alexander A'
  james  = Author.new 'James B'
  david   = Author.new 'David C'
  william = Author.new 'William D'

  book1 = Book.new 'AAAAAA', alexander
  book2 = Book.new 'BBBBBB', james
  book3 = Book.new 'CCCCCC', david
  book4 = Book.new 'DDDDDD', william

  nick   = Reader.new 'Nick', 'nick@mail.com', 'city1', 'street1'
  mark = Reader.new 'Mark', 'mark@mail.com', 'city2', 'sreet2'
  paul   = Reader.new 'Paul', 'paul@mail.com', 'city3', 'street3'
  kevin   = Reader.new 'Kevin', 'kevin@mail.com', 'city4', 'street4'

  library.add_order (Order.new(book1, nick))
  library.add_order (Order.new(book1, nick))
  library.add_order (Order.new(book1, mark))
  library.add_order (Order.new(book1, paul))
  library.add_order (Order.new(book2, kevin))
  library.add_order (Order.new(book2, nick))
  library.add_order (Order.new(book3, mark))
  library.add_order (Order.new(book4, nick))
  library.add_order (Order.new(book3, kevin))


puts library.most_popular_book

puts
puts "Who often takes the book?"
puts book = library.books[0]
puts library.often_takes_the_book book

puts
puts "How many people ordered one of the three most popular books?"

library.how_many_people_ordered_one_of_three_most_popular_books.each do |book, readers|
  puts "#{book.title} (#{book.author.name}): #{readers}"
end

library.save_to_file

puts library.read_from_file
=end
