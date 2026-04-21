module ContactsHelper
  def contact_initials(contact)
    "#{contact.firstname[0]}#{contact.lastname[0]}".upcase
  end

  def contact_initials_color(contact)
    #trying for different colours based on initials
    colours =["bg-cyan-500","bg-slate-500","bg-blue-500","bg-indingo-500","bg-green-500","bg-blue-500","bg-red-500"]
    index = (contact.firstname+contact.lastname).to_s.sum % colours.length
    colours[index]
  end
end
