namespace :seed do
  desc "seed database books and author"
  task author_books: :environment do
    author_name = %w{harun mela rachmat wawan alviando}
    book_title = %w{belajar-laravel belajar-vue belajar-angular belajar-js belajar-ror}
    5.times do |t|
      @author = Author.create(name: author_name[t])
      5.times do |e|
        @book = @author.books.find_or_create_by(title: book_title[e])
        @book.price = rand * 12.500
        @book.save!
        @book
      end
      puts "[SUCCESS] #{t}"
    end
  end
end
