class Pathname
  
  # Gets just the extension of the pathname
  #
  # @return [String] the extension of the path, without the '.'
  def extension
    self.extname[1..-1]
  end
  
  # Gets the name of the file without the extension
  #
  # @return [String] name of the file
  def file_name
    self.basename.to_s[0...-(self.extension.size+1)]
  end

end
