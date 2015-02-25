class OscarsConversionRate
  def initialize
    options = { "format" => "plaintext" }
    @client = WolframAlpha::Client.new ENV["WOLFRAM_ALPHA_API_KEY"], options
  end

  def conversion_rate_for(actor)
    nominations, wins = count_nominations_and_wins_for(actor)
    nominations += wins
    result = wins.to_f / nominations
    result = 1 if result.infinite?
    result = 0 if result.nan?
    result = result.round(4) * 100
    { name: actor, conversion_rate: result.to_s,
      wins: wins.to_s, nominations: nominations.to_s }
  end

  def count_nominations_and_wins_for(actor)
    response = @client.query "#{actor} oscar nominations"
    nominations = response.pods.last.subpods.first
    result = nominations.plaintext
    [result.scan(/nominee/).count, result.scan(/winner/).count]
  end
end
