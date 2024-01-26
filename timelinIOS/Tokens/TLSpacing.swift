import Foundation


enum TLSpacing: CaseIterable {
    case s64, s56, s48, s40, s32, s24, s16, s8, s4
    
    var size: CGFloat {
        switch self {
            case .s4: return 4
            case .s8: return 8
            case .s16: return 16
            case .s24: return 24
            case .s32: return 32
            case .s40: return 40
            case .s48: return 48
            case .s56: return 56
            case .s64: return 64
        }
    }
}
