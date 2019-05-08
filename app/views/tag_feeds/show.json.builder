json.version 'https://jsonfeed.org/version/1'
json.title 'Markcase'
json.home_page_url @base_url
json.feed_url "#{@root_url}/feed.json"
json.favicon "#{@root_url}/favicon.ico"

json.items @bookmarks do |bookmark|
  json.id bookmark.id
  json.context_text bookmark.title
  json.url bookmark.url
end