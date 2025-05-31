/// ゲームのロジックを管理するアクター
public actor GameModel {
    private var _problems: [FFProblem]
    private var _currentProblem: FFProblem?
    private var _score: Int
    private var _combo: Int
    
    public var currentProblem: FFProblem? {
        return _currentProblem
    }
    public var score: Int {
        return _score
    }
    public var combo: Int {
        return _combo
    }
        
    
    public init() {
        self._problems = []
        self._score = 0
        self._combo = 0
    }
    
    /// ゲームを開始する
    public func startGame() {
        self._problems = FFProblem.generateProblem(for: 1000)
        self._score = 0
        self._combo = 0
        
        self._currentProblem = pickNextProblem()
    }
    
    private func pickNextProblem() -> FFProblem? {
        guard !_problems.isEmpty else { return nil }
        return _problems.popLast()
    }
    
    /// 現在の問題に対する回答を行う
    public func answerCurrentProblem(with answer: FNumber) -> Bool {
        guard let currentProblem = _currentProblem else { return false }
        let isCorrect = currentProblem.answer == answer
        if isCorrect {
            _score += ScoreSetting.acceptedPoints + ScoreSetting.calculateBonus(combo: _combo)
            _combo += 1
        } else {
            _score += ScoreSetting.failedPoints
            _combo = 0
        }
        self._currentProblem = pickNextProblem()
        return isCorrect
    }
}
