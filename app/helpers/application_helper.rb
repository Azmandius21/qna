module ApplicationHelper
  def class_by_string(object, quantity=1)
    klass = object.class.to_s.downcase
    klass = klass.pluralize if quantity > 1
    return klass
  end
end
