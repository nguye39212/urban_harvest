module MapHelper

  def generate_map_url(donations, zoom=10)
   url = "http://maps.googleapis.com/maps/api/staticmap?center="
   # Center the Map on the Food Bank viewing it
   url += "#{current_user.latitude},#{current_user.longitude}"
   # Add each donation as a marker
   donations.each_with_index do |d, i|
     url += "&markers=color:blue|label:#{i+1}|#{d.latitude},#{d.longitude}"
   end
   # Add zoom, size, and api key info
   url +=  "&zoom=#{zoom}&size=1280x800&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
   return url
  end


end