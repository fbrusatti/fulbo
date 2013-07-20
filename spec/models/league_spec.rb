require 'spec_helper'

describe League do

  # validate presences
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:start_date) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:category) }
  it { should allow_mass_assignment_of(:number_matches) }
  it { should allow_mass_assignment_of(:field_price) }
  it { should allow_mass_assignment_of(:registration_price) }
  it { should allow_mass_assignment_of(:requirements) }
  it { should allow_mass_assignment_of(:number_teams) }
  it { should allow_mass_assignment_of(:start_date) }


  # belongs to
  it { should belong_to(:organizer) }

  # has one
  it { should have_one(:point_system) }
  it { should have_one(:fixture) }

  #has many
  it { should have_many(:affiliations) }
  it { should have_many(:teams).through(:affiliations) }

  # nested attributes
  it { should accept_nested_attributes_for(:point_system) }

  it "each league has a point system associated when it is created" do
    league = FactoryGirl.create(:league)
    assert_not_nil league.point_system
  end

  describe "Create a fixture of League" do

    before do
      @league = FactoryGirl.create(:league)
      6.times{ @league.teams << FactoryGirl.create(:team) }
      @rules = [RRSchedule::Rule.new(wday: 0,
                                      gt: ["7:00 PM","9:00 PM"],
                                      ps: ["1","2","3"]),
                RRSchedule::Rule.new(wday: 1,
                                     gt: ["7:00 PM","9:00 PM"],
                                     ps: ["1","3"])
               ]
      @schedule = RRSchedule::Schedule.new(teams: @league.team_ids,
                                           rules: @rules,
                                           start_date: @league.start_date
                                          ).generate
      @league.generate_fixture(@rules)
    end

    it "should generate Week models" do
      assert_equal @schedule.gamedays.count, Week.all.count
    end

    before do
      @games_per_week = @schedule.gamedays.map { |gd| gd.games.count }
      @matches_per_week = @league.fixture.weeks.map { |wk| wk.matches.count }
    end

    it "should generate Matches per weeks" do
      @games_per_week.should =~ @matches_per_week
    end

    it "each match has a visitor, a local and a Reservation " do
      Match.find_each do  |match|
        assert_not_nil match.reservation
        assert_not_nil match.visitor_id
        assert_not_nil match.local_id
      end
    end

    it "each Reservation has a field" do
      Reservation.find_each { |r| assert_not_nil r.field_id }
    end
  end
end
