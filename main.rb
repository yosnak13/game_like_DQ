class Brave

  def initialize
    @name = "テリー"
    @hp = 500
    @offense = 150
    @defense = 100
  end

  #nameのセッター（インスタンス変数の値をクラス内で更新するためのメソッド）
  #initializeで不要に
  # def name=(name)
  #   @name = name
  # end

  #nameのゲッター（インスタンス変数の値を取得してクラス外から参照可能）
  def name
    @name
  end

  def hp
    @hp
  end

  def offense
    @offense
  end

  def defense
    @defense
  end

end

brave = Brave.new

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT
