import UIKit
import SwiftUI

class TLTodoCard: UIView {
    var dateLabel: TLTypography!
    var titleLabel: TLTypography!
    var createdAt: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  convenience init(title todoTitle: String, description todoDescription: String, colour palette: TLColours.TodoPalette = .green, createdAt: String) {
        self.init(frame: .zero)
        self.createdAt = createdAt
        dateLabel = TLTypography(title: todoTitle, fontSize: .body, colour: .label)
        titleLabel = TLTypography(title: todoDescription, fontSize: .body, colour: .label)

        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail

        backgroundColor = palette.color

        addSubview(dateLabel)
        addSubview(titleLabel)
        configureConstraints()
    }

    private func configuration(){
        self.layer.cornerRadius = TLSpacing.s8.size
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: TLSpacing.s16.size),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -TLSpacing.s16.size),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: TLSpacing.s16.size),

            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: TLSpacing.s8.size),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: TLSpacing.s16.size),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -TLSpacing.s16.size)
        ])
    }
}


#if DEBUG
#Preview {
    let card = TLTodoCard(title: "Glopi orders", description: "Make 15 Glopi orders in 15 days", createdAt: "12 Jun 2024")

    NSLayoutConstraint.activate(
        [card.heightAnchor.constraint(equalToConstant: 200)])
    return card
}
#endif

