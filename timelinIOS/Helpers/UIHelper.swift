import UIKit


class UIHelper {
    typealias Padding = () ->
    (paddingRight: CGFloat, paddingTop: CGFloat,paddingLeft: CGFloat, paddingBottom:CGFloat)
    
    
    static func toCenter(this child: UIView, into parent: UIView, constants: Padding? = nil){
        var pRight: CGFloat = 0, pTop: CGFloat = 0, pLeft: CGFloat = 0, pBottom: CGFloat = 0
        
        if let (paddingRight,paddingTop,paddingLeft,paddingBottom) = constants?() {
            pRight = paddingRight
            pTop = paddingTop
            pLeft = paddingLeft
            pBottom = paddingBottom
        }
        
        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: parent.topAnchor, constant: pTop),
            child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: pRight),
            child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -pLeft),
            child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: pBottom)
        ])
        
        
    }
}
