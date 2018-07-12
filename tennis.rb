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
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end
      
  def won_point(playerName)
    if playerName == @player1Name
      p1Score()
    else
      p2Score()
    end
  end

  def score
    result = ""
    if (@p1points == @p2points and @p1points < 3)
      if (@p1points==0)
        result = "Love"
      end
      if (@p1points==1)
        result = "Fifteen"
      end
      if (@p1points==2)
        result = "Thirty"
      end
      result += "-All"
    end
    if (@p1points==@p2points and @p1points>2)
        result = "Deuce"
    end
    
    p1res = ""
    p2res = ""
    if (@p1points > 0 and @p2points==0)
      if (@p1points==1)
        p1res = "Fifteen"
      end
      if (@p1points==2)
        p1res = "Thirty"
      end
      if (@p1points==3)
        p1res = "Forty"
      end
      p2res = "Love"
      result = p1res + "-" + p2res
    end
    if (@p2points > 0 and @p1points==0)
      if (@p2points==1)
        p2res = "Fifteen"
      end
      if (@p2points==2)
        p2res = "Thirty"
      end
      if (@p2points==3)
        p2res = "Forty"
      end
      
      p1res = "Love"
      result = p1res + "-" + p2res
    end
    
    if (@p1points>@p2points and @p1points < 4)
      if (@p1points==2)
        p1res="Thirty"
      end
      if (@p1points==3)
        p1res="Forty"
      end
      if (@p2points==1)
        p2res="Fifteen"
      end
      if (@p2points==2)
        p2res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p2points>@p1points and @p2points < 4)
      if (@p2points==2)
        p2res="Thirty"
      end
      if (@p2points==3)
        p2res="Forty"
      end
      if (@p1points==1)
        p1res="Fifteen"
      end
      if (@p1points==2)
        p1res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p1points > @p2points and @p2points >= 3)
      result = "Advantage " + @player1Name
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = "Advantage " + @player2Name
    end
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + @player1Name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |i|
        p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
  end

  def p1Score
    @p1points +=1
  end
  
  def p2Score
    @p2points +=1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end
      
  def won_point(n)
    if n == @p1N
        @p1 += 1
    else
        @p2 += 1
    end
  end
  
  def score
    if (@p1 < 4 and @p2 < 4) and (@p1 + @p2 < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? s + "-All" : s + "-" + p[@p2]
    else
      if (@p1 == @p2)
        "Deuce"
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1-@p2)*(@p1-@p2) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
