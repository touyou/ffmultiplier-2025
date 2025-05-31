/// ゲームのロジックを管理するアクター
public actor GameModel {
    public var problems: [FFProblem]
    public var currentProblem: FFProblem?
    public var score: Int
    public var combo: Int
    
    public init() {
        self.problems = []
        self.score = 0
        self.combo = 0
    }
    
    /// ゲームを開始する
    public func startGame() {
        self.problems = FFProblem.generateProblem(for: 1000)
        self.score = 0
        self.combo = 0
        
        self.currentProblem = pickNextProblem()
    }
    
    private func pickNextProblem() -> FFProblem? {
        guard !problems.isEmpty else { return nil }
        return problems.popLast()
    }
    
    /// 現在の問題に対する回答を行う
    public func answerCurrentProblem(with answer: FNumber) -> Bool {
        guard let currentProblem = currentProblem else { return false }
        let isCorrect = currentProblem.answer == answer
        if isCorrect {
            score += ScoreSetting.acceptedPoints + ScoreSetting.calculateBonus(combo: combo)
            combo += 1
        } else {
            score += ScoreSetting.failedPoints
            combo = 0
        }
        self.currentProblem = pickNextProblem()
        return isCorrect
    }
}
