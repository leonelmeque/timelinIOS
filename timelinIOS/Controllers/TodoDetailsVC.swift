//
//  TodoDetailsVC.swift
//  timelinapp
//
//  Created by Leonel Meque on 1/2/24.
//

import UIKit

class TodoDetailsVC: UIViewController {

   var container = UIScrollView()

   lazy var viewIdentifier = [String: UIView]()

   lazy var noteIcon = UIImage(named: "note.text")
   lazy var personsIcon = UIImage(named: "person.2.fill")

   lazy var motivationText = TLTypography(title: "", fontSize: .body, weight: .regular)
   lazy var startDateLabel = TLTypography(title: "Has not started", fontSize: .body, weight: .bold)
   lazy var endDateLabel = TLTypography(title: "No deadline", fontSize: .body, weight: .bold)

   lazy var descriptionTextInput = UITextField()

   lazy var stackViewPadding = TLSpacing.s16.size

   lazy var ICON_SIZE = TLSpacing.s40.size

   override func viewDidLoad() {
      super.viewDidLoad()
      configureHeader()
      configureScrollView()
      setupTodoDetailsRow()
      setupStartDateRow()
      setupEndDateRow()
    }


  private func configure(){
    
  }

  private func configureHeader() {
    let shareButton = UIBarButtonItem(title: "square.and.arrow.up")
    let deleteButton = UIBarButtonItem(systemItem: .trash)
    navigationController?.navigationItem.leftBarButtonItems = [shareButton, deleteButton]
  }

  private func configureScrollView() {
    let padding = TLSpacing.s16.size
    view.addSubview(container)
    container.translatesAutoresizingMaskIntoConstraints = false

    UIHelper.toCenter(this: container, into: view) {
      return (padding,0,padding,0)
    }
  }

  private func configureTodoNameRow(){

  }

  private func setupTodoDetailsRow() {
    let timelineIcon = UIImageView(image: UIImage(named: "calendar.day.timeline.left"))
    descriptionTextInput.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(timelineIcon)
    container.addSubview(descriptionTextInput)

    viewIdentifier["descriptionTextInput"] = descriptionTextInput

    UIHelper.setIconSizeContraints(for: timelineIcon,size: ICON_SIZE )
    NSLayoutConstraint.activate([
      timelineIcon.topAnchor.constraint(equalTo: container.topAnchor, constant: 100),
      timelineIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      descriptionTextInput.leadingAnchor.constraint(equalTo: timelineIcon.trailingAnchor, constant: TLSpacing.s8.size),
      descriptionTextInput.heightAnchor.constraint(equalToConstant: 52),
      descriptionTextInput.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -TLSpacing.s16.size),
      descriptionTextInput.centerYAnchor.constraint(equalTo: timelineIcon.centerYAnchor)
    ])

  }

  private func setupStartDateRow(){
    let _startDateLabel = layoutDateLabels(label: startDateLabel, color: TLColours.TodoPalette.green.color)
    let calendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))

    container.addSubview(calendarIcon)
    container.addSubview(_startDateLabel)
    
    viewIdentifier["startDateView"] = _startDateLabel

    UIHelper.setIconSizeContraints(for: calendarIcon,size: ICON_SIZE )

    guard let _descriptionTextInput = viewIdentifier["descriptionTextInput"] else {return}
    NSLayoutConstraint.activate([
      calendarIcon.topAnchor.constraint(equalTo: _descriptionTextInput.bottomAnchor, constant: TLSpacing.s16.size),
      calendarIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      _startDateLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: TLSpacing.s8.size),
      _startDateLabel.centerYAnchor.constraint(equalTo: calendarIcon.centerYAnchor)
    ])
  }

  private func setupEndDateRow(){
    let _endDateLabel = layoutDateLabels(label: endDateLabel, color: TLColours.TodoPalette.orange.color)
    let calendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))

    viewIdentifier["endDateLabel"] = _endDateLabel

    container.addSubview(calendarIcon)
    container.addSubview(_endDateLabel)

    guard let startLabelView = viewIdentifier["startDateView"] else {return}

    UIHelper.setIconSizeContraints(for: calendarIcon,size: ICON_SIZE)

    NSLayoutConstraint.activate([
      calendarIcon.centerYAnchor.constraint(equalTo: _endDateLabel.centerYAnchor),
      calendarIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      _endDateLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: TLSpacing.s8.size),
      _endDateLabel.topAnchor.constraint(equalTo: startLabelView.bottomAnchor, constant: TLSpacing.s24.size)
    ])

  }

  private func layoutDateLabels(label: UILabel, color: UIColor) -> UIView {
    let padding = TLSpacing.s8.size
    let containerView = UIView(frame: .zero)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false

    containerView.addSubview(label)
    containerView.backgroundColor = color
    containerView.layer.cornerRadius = padding
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding)
    ])

    containerView.heightAnchor.constraint(equalToConstant: 57).isActive = true

    return containerView
  }

}




#Preview {
  TodoDetailsVC()
}
