class Library
  attr_reader :name,
              :books,
              :authors,
              :checked_out_books

  def initialize(name)
    @name              = name
    @books             = []
    @authors           = []
    @checked_out_books = []
  end

  def add_author(author)
    @authors << author
    @books += author.books
  end

  def publication_time_frame_for(author)
    books_by_date = author.sort_books_by_year
    {
      start: books_by_date.first.publication_year,
      end: books_by_date.last.publication_year
    }
  end

  def checkout(book)
    if @books.include?(book)
      @checked_out_books << book
      @books.delete(book)
      true
    else
      false
    end
  end
end
