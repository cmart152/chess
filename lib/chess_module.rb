module Chess
  
  def on_board?(num)

    num.each do |item| 
      return false if item < 0 || item > 7
    end
    true
  end

end