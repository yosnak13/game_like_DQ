class Brave

  #new演算子から渡された引数（ハッシュ形式のみ）を受け取る
  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:pffense]
    @defense = params[:defense]
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

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT
