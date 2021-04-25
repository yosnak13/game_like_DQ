class Character
  attr_reader :offense, :defense
  attr_accessor :hp, :name

  #new演算子から渡された引数（ハッシュ形式のみ）を受け取る
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end
