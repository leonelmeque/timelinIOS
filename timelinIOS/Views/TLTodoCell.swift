import UIKit

class TLTodoCell: UICollectionViewCell {

    static let identifier = "TLTodoCell"
  
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TLTodoCard){
        let padding:CGFloat = TLSpacing.s8.size
        
        addSubview(model)
        
        model.bounds = self.bounds
        model.translatesAutoresizingMaskIntoConstraints = false
        
        UIHelper.toCenter(this: model, into: self) {
            return (paddingRight: padding, paddingTop: 0, paddingLeft:padding, paddingBottom: 0)
        }

    }
    
}
