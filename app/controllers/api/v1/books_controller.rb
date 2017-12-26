module Api
  module V1
    class BooksController < Api::ApplicationController
      before_action :set_author, only: %i{index show update destroy}
      before_action :set_book, only: %i{show update destroy}

      def index
        @books = @author.books
        render json: @books
      end

      def show
        render json: @book
      end

      def create
        success = -> (book) { render json: book, status: :created, location: book }
        failure = -> (book) { render json: book.errors, status: :unprocessable_entity }
        @book = @author.books.new(book_params)
        @book.save ? success.call(@book) : failure.call(@book)
      end

      def update
        success = -> (book) { render json: book }
        failure = -> (book) { render json: book.errors, status: :unprocessable_entity }
        @book.update(book_params) ? success.call(@book) : failure.call(@book)
      end

      def destroy
        @book.destroy
      end

      private
        def set_author
          @author = Author.find(params[:author_id])
        end

        def set_book
          @book = @author.books.find(params[:id])
        end

        def book_params
          params.require(:book).permit(:author_id, :title, :price)
        end
    end

  end
end
