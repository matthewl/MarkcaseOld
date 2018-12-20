class TagCloud
  def self.all
    sql = '
      with tags as (
        select unnest(tags) as tag_name from bookmarks
      )
      select count(*), tag_name
      from tags
      group by tag_name
      order by count DESC'
    @results = ActiveRecord::Base.connection.select_all(sql).to_hash
  end

  def self.all_tags_count
    sql = '
      with tags as (
        select unnest(tags) as tag_name from bookmarks
      )
      select count(*)
      from tags
      order by count DESC'
    @results = ActiveRecord::Base.connection.select_all(sql).to_hash
  end
end