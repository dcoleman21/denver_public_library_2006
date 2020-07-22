require 'minitest/autorun'
require 'minitest/pride'
require './lib/library'
require './lib/author'
require './lib/book'

class LibraryTest < Minitest::Test

  def test_exists
    dpl = Library.new("Denver Public Library")
    assert_instance_of Library, dpl
  end

  def test_attributes
    dpl = Library.new("Denver Public Library")
    assert_equal "Denver Public Library", dpl.name
    assert_equal [], dpl.books
    assert_equal [], dpl.authors
  end

  def test_can_add_authors_and_books
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({
      first_name: "Charlotte",
      last_name: "Bronte"
    })
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({
      first_name: "Harper",
      last_name: "Lee"
    })
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal [charlotte_bronte, harper_lee], dpl.authors
    assert_equal [jane_eyre, professor, villette, mockingbird], dpl.books
  end

  def test_has_a_publication_time_frame_for_authors_books
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({
      first_name: "Charlotte",
      last_name: "Bronte"
    })
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({
      first_name: "Harper",
      last_name: "Lee"
    })
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal ({:start=>"1847", :end=>"1857"}), dpl.publication_time_frame_for(charlotte_bronte)
    assert_equal ({:start=>"1960", :end=>"1960"}), dpl.publication_time_frame_for(harper_lee)
  end

  def test_cannot_checkout_books_that_do_not_exist
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    assert_equal false, dpl.checkout(mockingbird)
    assert_equal false, dpl.checkout(jane_eyre)
  end

  def test_book_can_be_checked_out
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal true, dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books
  end

  def test_cannot_checkout_currently_checkout_out_books
    skip
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal true, dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books
    assert_equal false, dpl.checkout(jane_eyre)
  end

end



# The `publication_time_frame_for` method takes an `Author` object as an argument
# and returns a hash with two key/value pairs:
#   * `:start` which points to the publication year of the `Author`'s first book.
#   * `:end` which points to the publication year of the `Author`'s last book.
