require 'deep_slice/version'

class Hash
  def deep_slice(*keys)
    # use self.class so sublclasses of Hash can be deep_sliced
    hash_klass = self.class
    result = hash_klass.new

    keys.each do |key|
      if key.is_a?(hash_klass)
        key.keys.each do |sub_key|
          if has_key?(sub_key)
            recursive_keys = key[sub_key]
            result[sub_key] = \
              if self[sub_key].is_a?(Array)
                self[sub_key].map { |val| val.deep_slice(*[recursive_keys].flatten) }
              else
                 self[sub_key].deep_slice(*[recursive_keys].flatten)
              end
          end
        end
      elsif has_key?(key)
        result[key] = self[key]
      end
    end

    result
  end
end
