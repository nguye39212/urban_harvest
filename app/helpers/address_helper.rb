module AddressHelper

  def display_address(user)
    address_html = ''
    address_html += "#{user.full_name} " if user.full_name.present?
    address_html += "<br>#{user.address_1}" if user.address_1.present?
    address_html += "<br>#{user.address_2}" if user.address_2.present?
    address_html += "<br>#{user.city}, #{user.state} #{user.zip_code}" if (user.city.present? && user.state.present? && user.zip_code.present?)
    address_html += "<br>P: #{user.phone}" if user.phone.present?
    address_html += "<br>E: #{user.email}" if user.email.present?

    return address_html
  end


end