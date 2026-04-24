module ContactsHelper
  def contact_initials(contact)
    initials = [contact.firstname,contact.lastname].compact.map{|name| name[0]}.join
    # "#{contact.firstname[0]}#{contact.lastname[0]}".upcase
    initials.upcase
  end

  def contact_initials_color(contact)
    #trying for different colours based on initials
    colours =["bg-cyan-500","bg-slate-500","bg-blue-500","bg-indigo-500","bg-green-500","bg-blue-500","bg-red-500"]
    name=[contact.firstname,contact.lastname].compact.join
    index = name.sum % colours.length
    colours[index]
  end
end
