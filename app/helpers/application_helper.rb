module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  include Pagy::Frontend

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: {id: id, fields: fields.gsub('\n', '')})
  end

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

  def error_message_for(object, attribute, options = {})
    content_tag(:small, object.errors.messages[attribute].join(','), class: 'form-text text-danger')
  end

  def humanize_search_results(results_count, query)
    return "No results found for '#{query}'" if results_count.zero?

    if results_count == 1
      return "Found one result for '#{query}'"
    else
      return "Found #{results_count} results for '#{query}'"
    end
  end
end
