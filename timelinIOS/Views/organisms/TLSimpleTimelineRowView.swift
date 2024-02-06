import UIKit

class TLSimpleTimelineRowView: UIView {
  lazy var circleDot = UIView()
  lazy var isNewTag = UIView()
  lazy var isNewUpdate = false
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

    addSubview(circleDot)

    NSLayoutConstraint.activate([
      circleDot.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      circleDot.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      circleDot.widthAnchor.constraint(equalToConstant: TLSpacing.s16.size),
      circleDot.heightAnchor.constraint(equalToConstant: TLSpacing.s16.size),

    ])
  }

  func setRowDateWithTitle(timestamp: Double, title: String) {
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

    if  Utils.checkIfUpdateIsRecent(with: timestamp) {
      configureIsNewTag()
    }

  }

  func configureIsNewTag() {
    let padding = TLSpacing.s4.size
    let label = TLTypography(title: "New", fontSize: .body, colour: TLColours.Success.s300.color)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center

    isNewTag.backgroundColor = TLColours.Success.s50.color
    isNewTag.layer.cornerRadius = TLSpacing.s8.size
    isNewTag.translatesAutoresizingMaskIntoConstraints = false
    addSubview(isNewTag)
    isNewTag.addSubview(label)

    NSLayoutConstraint.activate([
      isNewTag.leadingAnchor.constraint(equalTo: todo.trailingAnchor, constant: TLSpacing.s8.size),
      isNewTag.centerYAnchor.constraint(equalTo: todo.centerYAnchor),
      label.centerYAnchor.constraint(equalTo: isNewTag.centerYAnchor)
    ])

    UIHelper.toCenter(this: label, into: isNewTag){
      return (padding, padding, padding, -padding)
    }
  }
}


#Preview {
  let timelineRow = TLSimpleTimelineRowView()
  
  let currentDate = Date()
  let threeDaysInSeconds: TimeInterval = 3 * 24 * 60 * 60
  let lessThanThreeDaysAgoTimestampMilliseconds = currentDate.timeIntervalSince1970 - threeDaysInSeconds

  timelineRow.setRowDateWithTitle(timestamp: lessThanThreeDaysAgoTimestampMilliseconds * 1000, title: "Glopi orders")

  NSLayoutConstraint.activate(
      [timelineRow.heightAnchor.constraint(equalToConstant: 80),
       timelineRow.widthAnchor.constraint(equalToConstant: 300)])

  return timelineRow
}
