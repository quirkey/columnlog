class SuperHash < HashWithIndifferentAccess

  def deep_value(key_array)
    value = self
    Array(key_array).each do |key|
      value = value.fetch(key, nil) 
    end
    value
  rescue NoMethodError
    nil
  end
  
  def deep_merge(other_hash)
    self.merge(other_hash) do |key, old_val, new_val|
      self[key] = (old_val.is_a?(Hash) && new_val.is_a?(Hash)) ? old_val.deep_merge(new_val) : new_val
    end
  end
  
  def deep_find_and_replace(with_value, &block)
    self.each do |key,val|
      if yield(val)
        self[key] = with_value
      else
        self[key].deep_find_and_replace(with_value, &block) if self[key].is_a?(Hash)
      end
    end
    self
  end

  def deep_each(&block)
    self.each do |key, val|
      if self[key].is_a?(Hash)
        self[key].deep_each(&block)
      end
      yield(self, key, val)
    end
  end

  def deep_merge(other_hash)
    self.dup.to_hash.merge(other_hash) do |key, old_val, new_val|
      self[key] = (old_val.is_a?(Hash) && new_val.is_a?(Hash)) ? old_val.deep_merge(new_val) : new_val
    end
  end
  
  
  private
  def method_missing(m,*a)
    if m.to_s =~ /\?$/ && self.has_key?(m.to_s[0...-1])
      return !!self[m.to_s[0...-1]]
    end
    if m.to_s =~ /=$/
      self[$`] = a[0]
    elsif a.empty?
      self[m.to_s] 
    else
      super
    end
  end
end