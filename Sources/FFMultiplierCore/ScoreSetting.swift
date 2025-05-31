/// スコア算出の定数
enum ScoreSetting {
    /// 正解時のスコア
    static var acceptedPoints: Int {
        10
    }
    /// 不正解時のスコア
    static var failedPoints: Int {
        -5
    }
    /// コンボボーナス
    static var comboBonus: Int {
        5
    }
    /// コンボボーナスの最大値
    static var maxComboBonus: Int {
        15
    }
}

extension ScoreSetting {
    /// ボーナスを計算する
    static func calculateBonus(combo: Int) -> Int {
        let bonus = (combo /  5) * ScoreSetting.comboBonus
        return min(bonus, ScoreSetting.maxComboBonus)
    }
}
