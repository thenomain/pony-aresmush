module AresMUSH
  
  puts "======================================================================="
  puts "Limit attributes to 4. "
  puts "======================================================================="
  
 
  chars = []
  FS3Attribute.all.each do |a| 
    if (a.rating > 4)
      a.update(rating: 4)
      chars << a.character.name
    end
  end
  
  puts "Characters affected: #{chars.join(', ')}"
  puts "Upgrade complete!"
end