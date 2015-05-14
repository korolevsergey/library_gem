module Library
	class Order
	  attr_reader :book, :reader, :date

	  def initialize(book, reader)
	    @book, @reader, @date = book, reader, Time.now
	  end
	end
end