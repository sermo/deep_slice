require "deep_slice/version"
require 'pry'

class Hash
  def deep_slice(*elements)
    hash_klass = self.class
    result = hash_klass.new

    elements.each do |element|
      if element.is_a?(hash_klass)
        element.keys.each do |sub_element|
          if has_key?(sub_element)
            recursive_elements = element[sub_element]
            result[sub_element] = if recursive_elements.is_a?(hash_klass)
                                    self[sub_element].deep_slice(recursive_elements)
                                  else
                                    self[sub_element].deep_slice(*Array(recursive_elements))
                                  end
          end
        end
      elsif has_key?(element)
        result[element] = self[element]
      end
    end
    result
  end
end
