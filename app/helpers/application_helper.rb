module ApplicationHelper
  def class_by_string(object, quantity = 1)
    klass = object.class.to_s.downcase
    quantity > 1 ? klass.pluralize : klass
  end

  def to_class(data)
    data.to_s.capitalize.constantize
  end

  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(to_s)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end
end
