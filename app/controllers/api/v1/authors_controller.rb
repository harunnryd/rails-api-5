module Api
  module V1
    class AuthorsController < Api::ApplicationController
      before_action :set_author, only: [:show, :update, :destroy]

      def index
        @authors = Author.all
        render json: @authors
      end

      def show
        render json: @author
      end

      def create
        success = -> (author) { render(json: author, status: :created, location: author) }
        failure = -> (author) { render(json: author.errors, status: :unprocessable_entity) }
        @author = Author.new(author_params)
        @author.save ? success.call(@author) : failure.call(@author)
      end

      def update
        success = -> (author) { render(json: author) }
        failure = -> (author) { render(json: author.errors, status: :unprocessable_entity) }
        @author.update(author_params) ? success.call(@author) : failure.call(@author)
      end

      def destroy
        @author.destroy
      end

      private
        def set_author
          @author = Author.find(params[:id])
        end

        def author_params
          params.require(:author).permit(:name)
        end
    end
  end
end
