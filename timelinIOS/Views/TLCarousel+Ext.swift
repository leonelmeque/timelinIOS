import UIKit

extension TLCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TLTodoCell.identifier, for: indexPath)
                as? TLTodoCell else {return UICollectionViewCell()}
    
        let card = TLTodoCard(title: data[indexPath.row] , description: "To be added", colour: .orange)
      
        cell.configure(with: card)
        
        return cell
    }
}
