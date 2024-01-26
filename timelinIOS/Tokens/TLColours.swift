import UIKit

enum TLColours {
    enum Primary {
        case p500, p400, p300, p200, p100, p75, p50
        
        var color: UIColor {
            switch self {
                 case .p500: return UIColor(hex: "#3D3868")
                 case .p400: return UIColor(hex: "#464077")
                 case .p300: return UIColor(hex: "#645CAA")
                 case .p200: return UIColor(hex: "#7E78B8")
                 case .p100: return UIColor(hex: "#A5A0CE")
                 case .p75:  return UIColor(hex: "#BFBCDC")
                 case .p50:  return UIColor(hex: "#F0EFF7")
            }
        }
    }
    
    enum Success {
        case s500, s400, s300, s200, s100, s75, s50
        
        var color: UIColor {
            switch self {
            case .s500: return UIColor(hex: "#386d36")
            case .s400: return UIColor(hex: "#407d3e")
            case .s300: return UIColor(hex: "#5bb259")
            case .s200: return UIColor(hex: "#77bf75")
            case .s100: return UIColor(hex: "#a0d29f")
            case .s75:  return UIColor(hex: "#bcdfbb")
            case .s50:  return UIColor(hex: "#eff7ee")
            }
        }
    }
    
    enum Warning {
        case w500, w400, w300, w200, w100, w75, w50
        
        var color: UIColor {
            switch self {
            case .w500: return UIColor(hex: "#84712e")
            case .w400: return UIColor(hex: "#988235")
            case .w300: return UIColor(hex: "#d9ba4c")
            case .w200: return UIColor(hex: "#dfc66a")
            case .w100: return UIColor(hex: "#e9d797")
            case .w75:  return UIColor(hex: "#efe3b6")
            case .w50:  return UIColor(hex: "#fbf8ed")
            }
        }
    }
    
    enum Danger {
        case d500, d400, d300, d200, d100, d75, d50
        
        var color: UIColor {
            switch self {
            case .d500: return UIColor(hex: "#842e39")
            case .d400: return UIColor(hex: "#983541")
            case .d300: return UIColor(hex: "#d94c5d")
            case .d200: return UIColor(hex: "#df6a79")
            case .d100: return UIColor(hex: "#e997a1")
            case .d75:  return UIColor(hex: "#efb6bd")
            case .d50:  return UIColor(hex: "#fbedef")
            }
        }
    }
    
    enum Greys {
        case g500, g400, g300, g200, g100, g75, g50
        
        var color: UIColor {
            switch self {
            case .g500: return UIColor(hex: "#0d0c10")
            case .g400: return UIColor(hex: "#0f0e12")
            case .g300: return UIColor(hex: "#15141a")
            case .g200: return UIColor(hex: "#3d3c41")
            case .g100: return UIColor(hex: "#77777a")
            case .g75:  return UIColor(hex: "#9f9fa1")
            case .g50:  return UIColor(hex: "#e8e8e8")
            }
        }
    }
    
    enum Neutrals {
        case dark, white
        
        var color: UIColor {
            switch self {
            case .dark: return UIColor(hex: "#15141A")
            case .white: return UIColor(hex: "#FFFFFF")
            }
        }
    }

    enum TodoPalette {
        case blue, green, orange, pink, yellow
        
        var color: UIColor {
            switch self {
            case .blue: return UIColor(hex: "#E0EEFD")
            case .green: return UIColor(hex: "#E9FBF3")
            case .orange: return UIColor(hex: "#FDEEE0")
            case .pink: return UIColor(hex: "#FDE7F0")
            case .yellow: return UIColor(hex: "#FAFBE9")
            }
        }
    }
}


