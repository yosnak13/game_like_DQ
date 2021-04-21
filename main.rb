class Brave
  #attr_reader記述でゲッターを省略可能（アクセスメソッド）
  attr_reader :name, :offense, :defense
  attr_accessor :hp #書き換えができるようにaccessorを利用

  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  #new演算子から渡された引数（ハッシュ形式のみ）を受け取る
  def initialize(**params) #**は複数の引数をhashでまとめて受け取れる
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    puts "#{@name}の攻撃"

    attack_num = rand(4) #0~3の間でランダムに数字が変わる

    if attack_num == 0
      puts "必殺攻撃"
      # 攻撃力の1.5倍の数値が戻り値として返ってくる
      damage = calculate_special_attack - monster.defense
    else
      puts "通常攻撃"
      damage = @offense - monster.defense
    end

    monster.hp -= damage #モンスターの残りHPの計算・処理

    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end

  #nameのセッター（インスタンス変数の値をクラス内で更新するためのメソッド）
  #initializeで不要に
  # def name=(name)
  #   @name = name
  # end

  #nameのゲッター（インスタンス変数の値を取得してクラス外から参照可能）
  #attr_readerで不要に
  # def name
  #   @name
  # end

end

# puts <<~TEXT
# NAME:#{brave.name}
# HP:#{brave.hp}
# OFFENSE:#{brave.offense}
# DEFENSE:#{brave.defense}
# TEXT

# brave.hp -= 30

# puts "#{brave.name}はダメージを受けた！残りHPは#{brave.hp}だ"


class Monster
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]

    @transform_flag = false
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    #hp半分以下かつ、変身判定フラグがfalseの時に実行
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag = true
      transform
    end
    puts "#{@name}の攻撃"

    damage = @offense - brave.defense
    brave.hp -= damage

    puts <<~TEXT
    #{brave.name}は#{damage}のダメージを受けた
    #{brave.name}の残りHPは#{brave.hp}だ
    TEXT

  end

  private
  def transform

    transform_name = "ドラゴン"

    puts <<~EOS
    #{@name}は怒っている
    #{@name}はドラゴンに変身した
    EOS

    @offense *= POWER_UP_RATE
    @name = transform_name
  end
end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
brave.attack(monster)
monster.attack(brave)
