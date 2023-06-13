module ApplicationHelper
  def form_error_messages(object, attribute)
    return if object.errors[attribute].empty?
    errors = object.errors[attribute].uniq.map do |e|
      tag.li(object.class.human_attribute_name(attribute.to_sym)  + e, class: '')
    end
    tag.ul(safe_join(errors), class: '')
  end
end
