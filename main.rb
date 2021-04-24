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

    attack_type = decision_attack_type

    # damage = calculate_damage(monster, attack_type)
    damage = calculate_damage(target: monster, attack_type: attack_type)
    # cause_damage(monster, damage)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  #攻撃の種類を判定するメソッド
  def decision_attack_type
    attack_num = rand(4) #0~3の間でランダムに数字が変わる

    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attack"
    end
  end

  #ダメージ計算メソッド
  def calculate_damage(**params) #paramsで受け取る
    #変数に格納することによって将来のハッシュのキー
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage
    puts "#{target.name}は#{damage}のダメージを受けた"
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


class Monster
  attr_reader :offense, :defense
  attr_accessor :hp, :name

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
