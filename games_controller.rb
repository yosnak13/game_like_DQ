class GamesController
  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)
    build_characters(params)

    loop do
      @brave.attack(@monster)
      break if battle_end?#引数不要に
      @monster.attack(@brave)
      break if battle_end?#引数不要に
    end

    # if battle_result
    #   result = calculate_of_exp_and_gold#引数不要に
    #   puts "#{@brave.name}は戦いに勝った"
    #   puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
    # else
    #   puts "#{@brave.name}は戦いに負けた"
    #   puts "目の前が真っ暗になった"
    # end

    battle_judgment
  end


  private

  #キャラクターのインスタンスをインスタンス変数に格納
  def build_characters(**params)
    @brave = params[:brave]
    @monster = params[:monster]
  end

  def battle_end?#引数不要に
    character.hp <= 0 || @mosnter.hp <= 0
  end

  def brave_win? #引数不要に
    # boolean型のデータが返るメソッドには末尾に?をつける
    @brave.hp > 0
  end

  #勇者の勝敗によりメッセージを変更するメソッド
  def battle_judgment
    if brave_win?
      result = calculate_of_exp_and_gold
      puts "#{@brave.name}は戦いに勝った"
      puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
    else
      puts "#{@brave.name}は戦いに負けた"
      puts "目の前が真っ暗になった"
    end
  end

  def calculate_of_exp_and_gold#引数不要に
    exp = (monster.offense + monster.defense) * EXP_CONSTANT
    gold = (monster.offense + monster.defense) * GOLD_CONSTANT
    result = {exp:exp, gold:gold}

    result
  end
end
