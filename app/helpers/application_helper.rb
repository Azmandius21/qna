module ApplicationHelper
  def class_by_string(object, quantity = 1)
    klass = object.class.to_s.downcase
    quantity > 1 ? klass.pluralize : klass
  end
end
