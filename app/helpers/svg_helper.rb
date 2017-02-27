module SvgHelper

  def render_svg(name)
    file_path = "#{Rails.root}/app/assets/images/icons/svg/#{name}.svg"
    if File.exists?(file_path)
      return File.read(file_path).html_safe
    else
      return '(not found)'
    end
  end

end