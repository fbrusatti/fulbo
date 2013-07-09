# # -*- coding: utf-8 -*-
# # Configures your navigation
#
SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigation::Renderer::Bootstrap
  navigation.items do |primary|
    # Bootstrap classes for tabbed menu
    primary.dom_class = "nav nav-tabs nav-stacked"

    primary.item :data, I18n.t("sport_centers.show.information"),
                        :icon => ['icon-flag'] do |data|
       data.item :view, I18n.t("sport_centers.show.see"),
                        sport_center_path(@sport_center)
    end
    primary.item :locations, I18n.t("sport_centers.show.venues"), '#',
                             :icon => ['icon-home'] do |locations|
      locations.item :show,
                     I18n.t("sport_centers.show.see_venues"),
                     sport_center_locations_path(@sport_center)
      locations.item :new,
                     I18n.t("sport_centers.show.new_venue"),
                     new_sport_center_location_path(@sport_center)
    end
    primary.item :tournament,
                 I18n.t("sport_centers.show.tournaments"),'#',
                 :icon =>['icon-star'] do |tournaments|
      tournaments.item :show,
                       I18n.t("sport_centers.show.see_tournaments"),
                       sport_center_leagues_path(@sport_center)
      tournaments.item :new,
                       I18n.t("sport_centers.show.new_tournament"),
                       new_league_path
    end
  end
end
