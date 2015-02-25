class Stat < ActiveRecord::Base

  before_save :normalize_actors
  before_save :cache_rates

  def actors_array
    actors.split(",").map(&:strip)
  end

  def cache_rates
    self.statistics = calculate_rate.to_json
  end

  def calculate_rate
    result = []
    oscars = OscarsConversionRate.new
    actors_array.each do |actor|
      result << oscars.conversion_rate_for(actor)
    end
    result
  end

  def normalize_actors
    self.actors = actors.chomp(", ")
  end
end
