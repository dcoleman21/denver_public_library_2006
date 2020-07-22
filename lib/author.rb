class Author
  attr_reader :first_name,
              :last_name,
              :name,
              :books
  def initialize(info)
    @first_name = info[:first_name]
    @last_name  = info[:last_name]
    @name       = info[:first_name] + " " + info[:last_name]
    @books      = []
  end

  def write(title, publication_year)
    new_books = Book.new({
      title: title,
      publication_date: publication_year,
      author_first_name: first_name,
      author_last_name: last_name
    })

    @books << new_books
    return new_books
  end

  def sort_books_by_year
    @books.sort_by do |book|
      book.publication_year
    end 
  end
end
