class Hash
  def smart_append_to(key, value, delimeter=' ')
    if self[key].nil?
      self[key] ||= value
    else
      self[key] << delimeter if self[key].is_a?(String)
      self[key] << value
    end
  end
  
  def smart_merge(other)
    return self unless other.is_a? Hash and other.any?
    return other unless self.any?
    
    self.merge other do |key, left, right| 
      case left
        when Hash
          right.is_a?(Hash) ? left.smart_merge(right) : right
        when Array
          (left | [right]).flatten
        when String
          right.is_a?(Array) ? ([left]|right).flatten : right
        else right
      end
    end
  end
  
  def smart_merge!(other_hash)
    self.replace(empty? ? other_hash : smart_merge(other_hash))
  end
  
  def smart_update(other_hash)
    self.replace(other_hash.smart_merge(self))
  end
  
  def only_presented
    select {|_, v| v.present? }
  end
end