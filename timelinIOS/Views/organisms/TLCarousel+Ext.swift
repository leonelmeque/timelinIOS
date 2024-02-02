
import UIKit

extension TLCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TLTodoCardCell.identifier, for: indexPath)
                as? TLTodoCardCell else {return UICollectionViewCell()}

      let card = TLTodoCard(title: data[indexPath.row].todo , description: "To be added", colour: .orange, createdAt: data[indexPath.row].timestamp)

        cell.configure(with: card)

        return cell
    }
}
