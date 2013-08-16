# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

  def random_dob
    date1 = Time.new(1970)
    date2 = Time.new(2000)
    Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  end

  def random_date_league
    date1 = Time.new(2013,10)
    date2 = Time.new(2014,10)
    Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  end

  def create_team_with_profile(user)
    user.create_team(name:  Faker::Name.team)
    directory = "app/assets/images/seed_team_image/"
    user.team.profile_attributes = {
                    category:   [Faker::Name.category],
                    surface:    [Faker::Name.surface],
                    badge:      File.open("#{directory}#{Faker::Name.team_image}")}
    user.team.profile.save
  end

  def create_user
    user = User.create(email:                 Faker::Internet.email,
                       password:              "rewq",
                       password_confirmation: "rewq")
  end

  def create_user_with_profile
    user = create_user
    directory = "app/assets/images/seed_user_image/"
    user.profile.update_attributes(name:   Faker::Name.first_name,
             surname:          Faker::Name.last_name,
             nickname:         Faker::Name.nickname,
             playing_position: [Faker::Name.playing_position],
             foot:             Faker::Name.foot,
             dob:              random_dob,
             locality:         Faker::Address.locality,
             avatar:           File.open("#{directory}#{Faker::Name.user_image}"),
             features:         "El mejor jugador")
    user
  end

  def create_sport_center(user)
    name = Faker::Name.sport_center
    user.create_sport_center(name:    name,
                            slug:     name,
                            address:  Faker::Address.street_address,
                            cuit:     "20-12.345.698-7",
                            email:    user.email,
                            phone:    Faker::PhoneNumber.phone_number,
                            description: "El mejor Sport Center")
  end

  def create_location
    Location.create(name:         Faker::Name.location,
                    address:      Faker::Address.street_address,
                    description:  "Las Canchas Mas Bonitas",
                    locality:     Faker::Address.locality,
                    phone:        Faker::PhoneNumber.phone_number)
        
  end

  def create_field
    Field.create(name:        Faker::Address.province,
                 category:    Faker::Name.category,
                 surface:     Faker::Name.surface,
                 price:       "150.00",
                 description: [Faker::Name.field_description])
  end

  def create_league
    League.create(name:              Faker::Name.league,
                  category:           Faker::Name.category,
                  field_price:        "120.00",
                  registration_price: "500.00",
                  requirements:       "la mejor liga",
                  number_teams:       12,
                  start_date:         random_date_league)
  end

  def create_players_for_team(team)
    10.times do
        player = create_user_with_profile
        team.players << player
    end
    team.save
  end

  def create_fields_for_location(location)
    8.times do 
      field = create_field
      location.fields << field
    end
  end

  def create_locations_for_sport_center(sport_center)
    7.times do
      location = create_location
      create_fields_for_location(location)
      sport_center.locations << location
    end
  end

  def create_teams_with_players
    12.times do 
      owner_team = create_user_with_profile
      create_team_with_profile(owner_team)
      create_players_for_team(owner_team.team)
    end
  end

  def create_sport_center_with_locations
    owner = create_user_with_profile
    create_sport_center(owner)
    create_locations_for_sport_center(owner.sport_center)
    owner.sport_center
  end

  def create_sport_center_with_league(sport_center)
    sport_center.leagues << create_league
  end

  def create_fixture_for_league(league)
    Team.first(12).each { |team| league.teams << team }
    location = league.organizer.locations.first
    fields = location.fields.first(3)
    rules = [ RRSchedule::Rule.new(wday: 0,
                                   gt: ["7:00 PM","9:00 PM"],
                                   ps: ["#{fields.first._id}",
                                        "#{fields.second._id}",
                                        "#{fields.last._id}"]),
              RRSchedule::Rule.new(wday: 1,
                                   gt: ["7:00 PM","9:00 PM"],
                                   ps: ["#{fields.first._id}","#{fields.last._id}"])
             ]
    schedule = RRSchedule::Schedule.new(teams: league.team_ids,
                                        rules: rules,
                                        start_date: league.start_date).generate
    league.generate_fixture(rules: rules)
  end

  2.times do |t|
    puts "iteration #{t+1} of 2 for the seed"
    create_teams_with_players
    puts "created team with players"
    sport_center = create_sport_center_with_locations
    create_sport_center_with_league(sport_center)
    puts "created sport center with league"
    league = sport_center.leagues.first
    create_fixture_for_league(league)
    puts "created fixture for league"
  end
