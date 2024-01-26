import UIKit

class TLCarousel: UITableViewCell {
    static let identifier = "TLTodoCarouselCell"
    
    var data: [String] = []

    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 260, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        container.showsHorizontalScrollIndicator = false
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        
        container.register(TLTodoCell.self, forCellWithReuseIdentifier: TLTodoCell.identifier)
        
        return container
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        collectionView.bounds = contentView.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
    
        contentView.addSubview(collectionView)
        UIHelper.toCenter(this: collectionView, into: contentView)
    }
    
     func initCell(with data: [String]){
         self.data = data
         DispatchQueue.main.async {
             [weak self] in self?.collectionView.reloadData()
         }
    }
    
}
