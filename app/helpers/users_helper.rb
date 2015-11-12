module UsersHelper
  def options_provinces(user)
    if user.province.blank?
      []
    else
      Area.joins(:country).where("countries.name = ?", user.country).pluck(:name)
    end
  end

  def options_cities(user)
    if user.city.blank?
      []
    else
      City.joins(:area).where("areas.name = ?", user.province).pluck(:name)
    end
  end
end
