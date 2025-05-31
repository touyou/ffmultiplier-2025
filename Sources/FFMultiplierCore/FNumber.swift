/// 16進数を表す構造体
public struct FNumber: Equatable, Hashable {
    private let _value: Int
    
    /// 1の位の値
    public var value0: Int {
        return _value % 16
    }
    
    /// 16の位の値
    public var value1: Int {
        return _value / 16
    }
    
    public init(value: Int) {
        assert(value >= 0, "FNumber value must be non-negative")
        assert(value <= 15*15, "FNumber value must not exceed 15*15")
        self._value = value
    }
    
    public func times(_ rhs: FNumber) -> FNumber {
        return FNumber(value: self._value * rhs._value)
    }
    
    /// 乱数を生成する
    public static func random() -> FNumber {
        let value = Int.random(in: 0..<16)
        return FNumber(value: value)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_value)
    }
}
