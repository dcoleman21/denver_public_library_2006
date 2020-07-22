require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'
require './lib/author'

class AuthorTest < Minitest::Test

  def test_it_exists
    charlotte_bronte = Author.new({
      first_name: "Charlotte",
      last_name: "Bronte"
    })

    assert_instance_of Author, charlotte_bronte
  end

  def test_it_has_attributes
    charlotte_bronte = Author.new({
      first_name: "Charlotte",
      last_name: "Bronte"
    })

    assert_equal "Charlotte Bronte", charlotte_bronte.name
    assert_equal [], charlotte_bronte.books
  end

  def test_write_can_create_books
    charlotte_bronte = Author.new({
      first_name: "Charlotte",
      last_name: "Bronte"
    })
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    assert_instance_of Book, jane_eyre
    assert_equal "Jane Eyre", jane_eyre.title

    villette = charlotte_bronte.write("Villette", "1853")

    assert_instance_of Book, villette
    assert_equal [jane_eyre, villette], charlotte_bronte.books
  end
end
