
import UIKit

extension TLCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TLTodoCardCell.identifier, for: indexPath)
                as? TLTodoCardCell else {return UICollectionViewCell()}

      let todo = data[indexPath.row]
      let card = TLTodoCard(title: todo.todo , description: "To be added", colour: .orange, createdAt: Date.dateFormatter(from: Double(todo.timestamp)))

        cell.configure(with: card)

        return cell
    }
}
