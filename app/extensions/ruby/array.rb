class Array

  def / len
    array = []
    each_with_index do |element, index|
      array << [] if index % len == 0
      array.last << element
    end
    array
  end

end