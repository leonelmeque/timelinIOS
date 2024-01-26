import UIKit
import SwiftUI

class TLTypography: UILabel {
    
    enum TypographySize: CaseIterable{
        case largeTitle, title, body, caption
        
        var value: CGFloat {
            switch self {
                case .body: return TLSpacing.s16.size
                case .caption: return TLSpacing.s8.size
                case .title: return TLSpacing.s24.size
                case .largeTitle: return TLSpacing.s40.size
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, fontSize: TypographySize, colour: UIColor?){
        self.init(frame: .zero)
        text = title
        font = UIFont.systemFont(ofSize: fontSize.value, weight: .bold)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}

#if DEBUG
struct TLTypographyPreview: PreviewProvider {
    static var previews: some View {
        TLPresentableView {
            var subViewsArranged: [UIView] = []
            TLTypography.TypographySize.allCases.forEach {
                subViewsArranged.append(TLTypography(title: "Lorem Ipsum Dorem", fontSize: $0, colour: TLColours.Neutrals.dark.color))
            }
            
            return PreviewUI(subViewsArranged: subViewsArranged)
        }
    }
}
#endif
