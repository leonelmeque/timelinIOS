import UIKit

extension UIColor {
    convenience init(hex: String) {
        let beginning = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[beginning...])
        
        let scanner = Scanner(string: hexColor)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xff00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xff) / 255.0
        let _ = CGFloat((rgbValue & 0xff000000) >> 24) / 255.0
        
        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
    }
}
