import UIKit

class TodoDetailsVC: UIViewController, UIScrollViewDelegate {

  var container = UIScrollView()

  lazy var viewIdentifier = [String: UIView]()

  lazy var noteIcon = UIImage(named: "note.text")
  lazy var personsIcon = UIImage(named: "person.2.fill")

  lazy var motivationText = TLTypography(title: "", fontSize: .body, weight: .regular)

  lazy var startDateLabel = TLCustomDateTextField(label: "", color: TLColours.TodoPalette.green.color)
  lazy var startDatePicker = UIDatePicker()

  lazy var endDateLabel = TLCustomDateTextField(label: "", color: TLColours.TodoPalette.orange.color)
  lazy var endDatePicker = UIDatePicker()

  lazy var textChangeTodoStatusButton = TLTypography(title: "Update progress", fontSize: .body, colour: TLColours.Primary.p300.color, weight: .bold )

  lazy var descriptionTextInput = UITextField()
  lazy var todoNameTextInput = UITextField()
  lazy var stackViewPadding = TLSpacing.s16.size

  lazy var simpleTimelineView = TLSimpleTimelineView()


  lazy var timelineHorizontalLine = UIView()

  lazy var sectionSpacing: CGFloat = TLSpacing.s24.size
  lazy var timelineRowViews = [
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView()
  ]

  lazy var ICON_SIZE = TLSpacing.s32.size

  override func viewDidLoad() {
    super.viewDidLoad()
    configuration()
    configureHeader()
    configureScrollView()
    configureMotivationText()
    configureTodoNameRow()
    setupTodoDetailsRow()
    setupStartDateRow()
    createTimeline()
    setupEndDateRow()
    setuptextChangeTodoStatusButton()
  }

  private func configuration(){
    container.delegate = self
    view.backgroundColor = .systemBackground

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
    view.addGestureRecognizer(tapGesture)
  }

 @objc private func viewWasTapped(gestureRecognizer: UITapGestureRecognizer) {
    view.endEditing(true)
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

  private func configureMotivationText(){
    motivationText.translatesAutoresizingMaskIntoConstraints = false
    motivationText.text = "You rock!"
  
    container.addSubview(motivationText)
    
    NSLayoutConstraint.activate([
      motivationText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TLSpacing
        .s16.size),
      motivationText.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ICON_SIZE + TLSpacing.s16.size),
      motivationText.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -TLSpacing.s16.size),
    ])
  }

  private func configureTodoNameRow(){
    todoNameTextInput.placeholder = "Write something like Glopi is cool"
    todoNameTextInput.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(todoNameTextInput)

    viewIdentifier["todoNameTextInput"] = todoNameTextInput

    NSLayoutConstraint.activate([
      todoNameTextInput.topAnchor.constraint(equalTo: motivationText.topAnchor, constant: sectionSpacing),
      todoNameTextInput.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ICON_SIZE + TLSpacing.s16.size),
      todoNameTextInput.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -TLSpacing.s16.size),
      todoNameTextInput.heightAnchor.constraint(equalToConstant: 52)
    ])
  }

  private func setupTodoDetailsRow() {
    let timelineIcon = UIImageView(image: UIImage(systemName: "calendar.day.timeline.left"))
    timelineIcon.tintColor = .label

    descriptionTextInput.translatesAutoresizingMaskIntoConstraints = false
    timelineIcon.translatesAutoresizingMaskIntoConstraints = false
    descriptionTextInput.placeholder = "Write a cool description"
    container.addSubview(timelineIcon)
    container.addSubview(descriptionTextInput)

    viewIdentifier["descriptionTextInput"] = descriptionTextInput

    UIHelper.setIconSizeContraints(for: timelineIcon,size: ICON_SIZE )
    NSLayoutConstraint.activate([
      timelineIcon.topAnchor.constraint(equalTo: todoNameTextInput.bottomAnchor, constant: sectionSpacing),
      timelineIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      descriptionTextInput.leadingAnchor.constraint(equalTo: timelineIcon.trailingAnchor, constant: TLSpacing.s16.size),
      descriptionTextInput.heightAnchor.constraint(equalToConstant: 52),
      descriptionTextInput.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -TLSpacing.s16.size),
      descriptionTextInput.centerYAnchor.constraint(equalTo: timelineIcon.centerYAnchor)
    ])

  }

  private func setupStartDateRow(){
    let calendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))

    startDatePicker.datePickerMode = .date
    startDatePicker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)

    calendarIcon.tintColor = .label
    calendarIcon.translatesAutoresizingMaskIntoConstraints = false
    startDateLabel.translatesAutoresizingMaskIntoConstraints = false

    startDateLabel.inputView = startDatePicker

    container.addSubview(calendarIcon)
    container.addSubview(startDateLabel)

    UIHelper.setIconSizeContraints(for: calendarIcon,size: ICON_SIZE )


    NSLayoutConstraint.activate([
      calendarIcon.topAnchor.constraint(equalTo: descriptionTextInput.bottomAnchor, constant: sectionSpacing),
      calendarIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      startDateLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: TLSpacing.s16.size),
      startDateLabel.centerYAnchor.constraint(equalTo: calendarIcon.centerYAnchor)
    ])
  }

  private func createTimeline(){
    let icon = UIImageView(image: UIImage(systemName: "line.3.horizontal.decrease"))
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.tintColor = .label
    
    simpleTimelineView.translatesAutoresizingMaskIntoConstraints = false

    container.addSubview(simpleTimelineView)
    container.addSubview(icon)

    simpleTimelineView.buildTimeline(with: timelineRowViews)
    UIHelper.setIconSizeContraints(for: icon, size: ICON_SIZE)

    NSLayoutConstraint.activate([
      simpleTimelineView.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: sectionSpacing),
      simpleTimelineView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: TLSpacing.s16.size),
      simpleTimelineView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: TLSpacing.s16.size),

      icon.centerYAnchor.constraint(equalTo: simpleTimelineView.centerYAnchor),
      icon.leadingAnchor.constraint(equalTo: container.leadingAnchor),

    ])
  }

  private func setupEndDateRow(){
    let calendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))

    endDatePicker.datePickerMode = .date
    endDatePicker.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)

    endDateLabel.inputView = endDatePicker

    calendarIcon.translatesAutoresizingMaskIntoConstraints = false
    calendarIcon.tintColor = .label

    container.addSubview(calendarIcon)
    container.addSubview(endDateLabel)

    UIHelper.setIconSizeContraints(for: calendarIcon,size: ICON_SIZE)

    NSLayoutConstraint.activate([
      calendarIcon.centerYAnchor.constraint(equalTo: endDateLabel.centerYAnchor),
      calendarIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      endDateLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: TLSpacing.s16.size),
      endDateLabel.topAnchor.constraint(equalTo: simpleTimelineView.bottomAnchor, constant: sectionSpacing)
    ])

  }

  @objc private func endDateChanged(datePicker: UIDatePicker){
    DispatchQueue.main.async {
      self.endDateLabel.text = Date.dateFormatter(from: datePicker.date.timeIntervalSince1970 * 1000)
      self.view.endEditing(true)
    }
  }

  @objc private func startDateChanged(datePicker: UIDatePicker){
    DispatchQueue.main.async {
      self.startDateLabel.text = Date.dateFormatter(from: datePicker.date.timeIntervalSince1970 * 1000)
      self.view.endEditing(true)
    }
  }

  private func setuptextChangeTodoStatusButton() {
    textChangeTodoStatusButton.translatesAutoresizingMaskIntoConstraints = false
    textChangeTodoStatusButton.textAlignment = .center
    textChangeTodoStatusButton.isUserInteractionEnabled = true

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerMenu))
    textChangeTodoStatusButton.addGestureRecognizer(tapGesture)

    container.addSubview(textChangeTodoStatusButton)

    NSLayoutConstraint.activate([
      textChangeTodoStatusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -TLSpacing.s16.size),
      textChangeTodoStatusButton.centerXAnchor.constraint(equalTo: container.centerXAnchor)
    ])
  }

  @objc func triggerMenu() {
    let alert = UIAlertController(title: "Update status", message: "This will Change the status of the todo", preferredStyle: .actionSheet)

    alert.addAction(UIAlertAction(title: "Todo", style: .default, handler: {_ in}))
    alert.addAction(UIAlertAction(title: "In Progress", style: .default, handler: {_ in}))
    alert.addAction(UIAlertAction(title: "Completed", style: .default, handler: {_ in}))
    alert.addAction(UIAlertAction(title: "On Hold", style: .default, handler: {_ in}))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
    present(alert, animated: true, completion: nil)
  }

}

extension TodoDetailsVC {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset.y)
  }
}


#Preview {
  TodoDetailsVC()
}
