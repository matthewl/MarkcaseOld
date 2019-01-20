namespace :app do
  desc %Q{ ›› Migrate tags to acts_as_taggable }
  task :migrate_tags do
    if Bookmark.column_names.include?('old_tags')
      Bookmark.all.each do |bookmark|
        puts "Bookmark ##{bookmark.id}, tags: #{bookmark.old_tags}"
        bookmark.old_tags.each do |tag|
          bookmark.tag_list.add(tag)
        end
        bookmark.save
      end
    else
      puts "Migrating tags aborted - you don't need to migrate your tags."
    end
  end
end
