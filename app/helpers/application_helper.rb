module ApplicationHelper
  def tag_cloud_css_class(tag_count)
    total_count = TagCloud.all_tags_count.first['count']
    percent = (tag_count.to_f / total_count.to_f) * 100

    return 'tag-size-5' if percent > 10
    return 'tag-size-4' if percent > 5
    return 'tag-size-3' if percent > 2.5
    return 'tag-size-2' if percent > 1.25
    return 'tag-size-1' if percent > 0.625

    'tag-size-0'
  end
end
