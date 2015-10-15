json.array!(@books) do |book|
  json.extract! book, :id, :title
  json.url user_book_url([book.user, book], format: :json)
end
