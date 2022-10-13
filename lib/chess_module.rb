module Chess
  
  def on_board?(num)
    num.each do |item| 
      return false if item < 0 || item > 7
    end
    true
  end

  def check_for_file(file)
    if File.exist?("saves/#{file}.yaml")
      return file
    else
      puts "The file name you entered is incorrect or does not exist, try again"
      check_for_file(gets.chomp)
    end
  end

end