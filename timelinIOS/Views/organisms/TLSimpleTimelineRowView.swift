import UIKit

class TLSimpleTimelineView: UIView {

  lazy var circleDot = UIView()
  lazy var horizontalLine = UIView()
  var date = TLTypography()
  var todo = TLTypography()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure() {
    circleDot.frame = CGRect(x: 0, y: 0, width: TLSpacing.s16.size, height: TLSpacing.s16.size)
    circleDot.layer.cornerRadius = circleDot.frame.width / 2
    circleDot.backgroundColor = TLColours.Primary.p75.color
    circleDot.translatesAutoresizingMaskIntoConstraints = false

    horizontalLine.backgroundColor = TLColours.Primary.p75.color
    horizontalLine.translatesAutoresizingMaskIntoConstraints = false

    addSubview(circleDot)
    addSubview(horizontalLine)

    NSLayoutConstraint.activate([
      circleDot.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      circleDot.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      circleDot.widthAnchor.constraint(equalToConstant: TLSpacing.s16.size),
      circleDot.heightAnchor.constraint(equalToConstant: TLSpacing.s16.size),

      horizontalLine.centerXAnchor.constraint(equalTo: circleDot.centerXAnchor),
      horizontalLine.topAnchor.constraint(equalTo: circleDot.bottomAnchor),
      horizontalLine.widthAnchor.constraint(equalToConstant: 4),
      horizontalLine.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  func setRowDateWithTitle(timestamp: Double, title: String){
    let fontSystem = UIFont.systemFont(ofSize: TLSpacing.s16.size, weight: .bold)
    date.text = Date.dateFormatter(from: timestamp)
    date.font = fontSystem
    date.textColor = .label.withAlphaComponent(0.3)
    todo.text = title
    todo.font = fontSystem
    todo.textColor = .label.withAlphaComponent(0.6)

    addSubview(date)
    addSubview(todo)

    date.translatesAutoresizingMaskIntoConstraints = false
    todo.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      date.centerYAnchor.constraint(equalTo: circleDot.centerYAnchor),
      date.leadingAnchor.constraint(equalTo: circleDot.leadingAnchor, constant: TLSpacing.s32.size),

      todo.centerYAnchor.constraint(equalTo: circleDot.centerYAnchor),
      todo.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: TLSpacing.s8.size)
    ])
  }

  func createTimeline() {

  }
}



#Preview {
  let card = TLSimpleTimelineView()
  card.setRowDateWithTitle(timestamp: 1693957505641, title: "Glopi orders")
  NSLayoutConstraint.activate(
      [card.heightAnchor.constraint(equalToConstant: 200),
       card.widthAnchor.constraint(equalToConstant: 280)])

  return card
}
