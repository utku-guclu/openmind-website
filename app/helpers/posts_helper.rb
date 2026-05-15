module PostsHelper
  def post_icon(category)
    case category
    when "news"         then "megaphone"
    when "story"        then "book-open-text"
    when "update"       then "bell-ringing"
    when "announcement" then "megaphone"
    else "article"
    end
  end
end
