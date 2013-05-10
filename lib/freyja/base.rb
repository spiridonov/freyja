class Freyja::Base

  attr_accessor :source

  def initialize(source)
    self.source = ActiveSupport::HashWithIndifferentAccess.new(source)
  end

  def self.attributes(*args)
    @attributes = args
  end

  def self.has_one(attribute, translator = nil)
    @has_one ||= []
    @has_one << {
      attribute: attribute,
      class: translator,
    }
  end

  def self.has_many(attribute, translator = nil)
    @has_many ||= []
    @has_many << {
      attribute: attribute,
      class: translator,
    }
  end

  def self._attributes
    @attributes || []
  end

  def self._has_one
    @has_one || []
  end

  def self._has_many
    @has_many || []
  end

  def as_json
    result = translate_attributes
    result.merge!(translate_has_one)
    result.merge!(translate_has_many)
    result
  end

  protected

  def translate_attributes
    self.class._attributes.each.with_object({}) do |attr, result|
      if include?(attr)
        if self.respond_to?(attr)
          result[attr] = send(attr)
        else
          result[attr] = source[attr]
        end
      end
    end
  end

  def translate_has_one
    self.class._has_one.each.with_object({}) do |association, result|
      attr = association[:attribute]
      if include?(attr)
        if self.respond_to?(attr)
          value = send(attr)
        else
          value = source[attr]
        end
        if association[:class] && value.present?
          translator = association[:class].new(value)
          result[attr] = translator.as_json
        else
          result[attr] = value
        end
      end
    end
  end

  def translate_has_many
    self.class._has_many.each.with_object({}) do |association, result|
      attr = association[:attribute]
      if include?(attr)
        if self.respond_to?(attr)
          value = send(attr)
        else
          value = source[attr]
        end
        if association[:class] && value.present?
          result[attr] = value.map do |v|
            translator = association[:class].new(v)
            translator.as_json
          end
        else
          result[attr] = value
        end
      end
    end
  end

  def include?(attribute)
    if respond_to?("include_#{attribute}?")
      send("include_#{attribute}?")
    else
      true
    end
  end

end