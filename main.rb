class Brave < Character

  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster, attack_type: attack_type)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

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
    target.hp = 0 if target.hp < 0 #マイナスになるときは0を代入

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

end


class Monster < Character
  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    #キャラクタークラスのinitializeメソッドに処理を渡す
    # 通常のメソッドと同様に引数を渡すことができる
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
    #親クラスで定義していない処理はそのまま残す
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

    damage = calculate_damage(brave)
    cause_damage(target: brave, damage: damage)

    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

  def calculate_damage(target)
    @offense - target.defense
  end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage
    target.hp = 0 if target.hp < 0 #hpがマイナスになるときは0を代入
    puts "#{target.name}は#{damage}のダメージを受けた"
  end

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

loop do
  brave.attack(monster)
  if monster.hp <= 0
    break
  end

  monster.attack(brave)
  if brave.hp <= 0
    break
  end
end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) * 3
  puts "#{brave.name}は戦いに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}は戦いに負けた"
  puts "目の前が真っ暗になった"
end
