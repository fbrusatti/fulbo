module FixturesHelper

  def fixture_days
    options = ""
    t("date.day_names").each_with_index do |day, index|
      check_box = check_box_tag index, day
      day_label = label_tag "day_label", day
      options << check_box + day_label
    end
    options_div = content_tag :div, options.html_safe, class: "check_days"
  end

  def fixture_places(league)
    options = ""
    league.organizer.fields.each do |field|
      check_box = check_box_tag "rules[][#{:fields}][]", field.id
      label = label_tag "place_label", field.name
      options << check_box + label
    end
    options.html_safe
  end

end
