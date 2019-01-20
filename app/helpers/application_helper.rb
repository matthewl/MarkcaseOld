module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  include Pagy::Frontend

  def bundles
    return Account.first.bundles if current_account
    Account.first.bundles.shared
  end

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
end
