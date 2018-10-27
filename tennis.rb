class Player
  attr_reader :name, :points
  
  def initialize(name)
    @name = name
    @points = 0
  end

  def won_point
    @points += 1
  end

  def lead_over(player)
    @points - player.points
  end
end

class TennisGame1
  attr_reader :player1, :player2
  
  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name)
    @player2 = Player.new(player2Name)
  end
        
  def won_point(playerName)
    if playerName == @player1.name
      @player1.won_point
    else
      @player2.won_point
    end
  end
  
  def score
    return 'Deuce' if deuce?
    return advantage(player1.name) if advantage?(player1)
    return advantage(player2.name) if advantage?(player2)
    return wins(player1.name) if won?(player1)
    return wins(player2.name) if won?(player2)

    return "#{in_words(player1.points)}-All" if player1.lead_over(player2) == 0
    
    "#{in_words(player1.points)}-#{in_words(player2.points)}"
  end

  private
  POINTS_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
  }.freeze
    
  def deuce?
    player1.lead_over(player2) == 0 && player1.points >= 3
  end

  def advantage?(player)
    opposition = ([player1, player2] - [player]).first
    player.lead_over(opposition) == 1 && player.points >= 4
  end

  def won?(player)
    opposition = ([player1, player2] - [player]).first
    player.lead_over(opposition) >= 2 && player.points >= 4
  end
  
  def wins(player)
    "Win for #{player}"
  end

  def advantage(player)
    "Advantage #{player}"
  end

  def in_words(points)
    POINTS_IN_WORDS[points]
  end
end

class TennisGame2
  attr_reader :player1, :player2
  
  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name)
    @player2 = Player.new(player2Name)
  end
      
  def won_point(playerName)
    if playerName == player1.name
      @player1.won_point
    else
      @player2.won_point
    end
  end

  def score
    return "Deuce" if deuce?
    return advantage(player1.name) if advantage?(player1)
    return advantage(player2.name) if advantage?(player2)
    return wins(player1.name) if won?(player1)
    return wins(player2.name) if won?(player2)

    if (player1.lead_over(player2) == 0 && player1.points < 3)
      return "#{in_words(player1.points)}-All"
    end

    "#{in_words(player1.points)}-#{in_words(player2.points)}"
  end

  private
  def deuce?
    player1.lead_over(player2) == 0 && player1.points >= 3
  end

  def advantage?(player)
    opposition = ([player1, player2] - [player]).first
    player.lead_over(opposition) == 1 && player.points >= 4
  end
  
  def advantage(player)
    "Advantage #{player}"
  end

  def won?(player)
    opposition = ([player1, player2] - [player]).first

    player.lead_over(opposition) >=2 &&
      (player.points >= 4 && opposition.points >= 0)
  end

  def wins(player)
    "Win for #{player}"
  end
  
  POINTS_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
  }.freeze
  
  def in_words(points)
    POINTS_IN_WORDS[points]
  end
end

class TennisGame3
  attr_reader :player1, :player2
  
  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name)
    @player2 = Player.new(player2Name)
  end
      
  def won_point(player_name)
    if player_name == player1.name
      @player1.won_point
    else
      @player2.won_point
    end
  end
  
  def score
    return "Deuce" if deuce?
    if(player1.points > 3 || player2.points > 3)
      return "Advantage #{leading_player}" if lead.magnitude == 1
      return "Win for #{leading_player}" if lead.magnitude > 1
    end

    if player1.lead_over(player2) == 0
      return "#{POINTS_AS_WORDS[player1.points]}-All"
    end
    "#{POINTS_AS_WORDS[player1.points]}-#{POINTS_AS_WORDS[player2.points]}"
  end

  private

  POINTS_AS_WORDS = %w{Love Fifteen Thirty Forty}.freeze

  def leading_player
    player1.points > player2.points ? player1.name : player2.name
  end
  
  def deuce?
    player1.points >= 3 && player2.points >= 3 &&
      player1.lead_over(player2) == 0
  end

  def lead
    player1.lead_over(player2)
  end
end
