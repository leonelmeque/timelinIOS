import UIKit

class TLSimpleTimelineView: UIView {

  lazy var timelineHorizontalLine = UIView()
  lazy var viewMoreText = TLTypography(title: "See more", fontSize: .body, colour:TLColours.Primary.p300.color, weight: .bold)

  override init(frame: CGRect) {
    super.init(frame: frame)
    configuration()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configuration (){
    timelineHorizontalLine.translatesAutoresizingMaskIntoConstraints = false
    timelineHorizontalLine.backgroundColor = TLColours.Primary.p75.color
    addSubview(timelineHorizontalLine)
  }

  func buildTimeline(with model: [TLSimpleTimelineRowView]){
    let lastThree = model.count - 3
    print(lastThree)
    let lastThreeUpdates = lastThree <= 0 ? model : Array(model[lastThree...model.count - 1])
    var auxEvent: TLSimpleTimelineRowView!

    for (index, event) in lastThreeUpdates.enumerated() {
      // add to subview
      event.translatesAutoresizingMaskIntoConstraints = false
      addSubview(event)

      // set the data
      event.setRowDateWithTitle(timestamp: 1693957505641, title: "Glopi orders")

      let bottomAnchorValue = auxEvent != nil ? auxEvent.bottomAnchor : self.topAnchor
      let bottomAnchorConstantValue = auxEvent != nil ? TLSpacing.s16.size * 3 : 0

      if index == 0 {
        event.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
      } else {
        event.bottomAnchor.constraint(equalTo: bottomAnchorValue , constant: bottomAnchorConstantValue).isActive = true
      }

      // setup constraints
      NSLayoutConstraint.activate([
        event.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        event.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        event.heightAnchor.constraint(equalToConstant: 20)
      ])

      layoutIfNeeded()

      // save the reference for later
      auxEvent = event
    }

    if lastThreeUpdates.count > 1 {
      buildHorizontalLine(from: lastThreeUpdates.first ?? nil, to: lastThreeUpdates.last ?? nil)
    }

    addShowMoreTextBellow(this: lastThreeUpdates.last ?? nil)
  }

  private func addShowMoreTextBellow(this event: TLSimpleTimelineRowView?) {
    guard let event = event else {return}

    addSubview(viewMoreText)
    viewMoreText.text = "See more"
    viewMoreText.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      viewMoreText.topAnchor.constraint(equalTo: event.bottomAnchor, constant: TLSpacing.s16.size),
      viewMoreText.leadingAnchor.constraint(equalTo: event.date.leadingAnchor),
      viewMoreText.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  private func buildHorizontalLine(from: TLSimpleTimelineRowView?, to: TLSimpleTimelineRowView?){
    guard let first = from else {return}
    guard let last = to else {return}

    NSLayoutConstraint.activate([
      timelineHorizontalLine.centerXAnchor.constraint(equalTo: first.circleDot.centerXAnchor),
      timelineHorizontalLine.topAnchor.constraint(equalTo: first.circleDot.bottomAnchor),
      timelineHorizontalLine.widthAnchor.constraint(equalToConstant: 4),
      timelineHorizontalLine.heightAnchor.constraint(equalToConstant: last.frame.origin.y)
    ])
  }
}
