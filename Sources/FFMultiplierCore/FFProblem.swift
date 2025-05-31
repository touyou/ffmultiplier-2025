public struct FFProblem: Equatable, Hashable {
    let a: FNumber
    let b: FNumber
    
    public var answer: FNumber {
        return a.times(b)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
}

extension FFProblem {
    /// 問題の生成
    public static func generateProblem(for count: Int) -> [FFProblem] {
        var problems: Set<FFProblem> = []
        while problems.count < count {
            let a = FNumber.random()
            let b = FNumber.random()
            let problem = FFProblem(a: a, b: b)
            problems.insert(problem)
        }
        
        return Array(problems).shuffled()
    }
}
