class String

  def to_boolean
    return false if ["f", "0", "false"].include?(self.downcase)
    return true if ["t", "1", "true"].include?(self.downcase)
    return false
  end

end