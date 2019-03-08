import Foundation

public enum AboutWindowControllerState {
    case collapsed
    case expanded
    
    var yDiff: CGFloat {
        switch self {
        case .expanded:
            return -100
        case .collapsed:
            return 100
        }
    }
    
    func toggle() -> AboutWindowControllerState {
        switch self {
        case .collapsed:
            return .expanded
        case .expanded:
           return .collapsed
        }
    }
}
