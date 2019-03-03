xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'Markcase'
    xml.description 'An open source bookmark manager'
    xml.link root_url

    @bookmarks.each do |bookmark|
      xml.item do
        xml.title "Bookmarked: #{bookmark.title}"
        xml.description bookmark.description
        xml.pubDate bookmark.created_at.to_s(:rfc822)
        xml.link bookmark.url
        xml.guid bookmark_url(bookmark)
      end
    end
  end
end
