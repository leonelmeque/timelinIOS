import UIKit
import RxSwift

final class TodoDetailsVC: UIViewController {
  // MARK: - Properties
  let todoDetailsViewModel = TodoDetailsViewModel()
  lazy var stackViewPadding = TLSpacing.s16.size
  lazy var sectionSpacing: CGFloat = TLSpacing.s24.size
  var constraints: [NSLayoutConstraint] = []
  let padding16 = TLSpacing.s16.size

  lazy var timelineRowViews = [
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView(),
    TLSimpleTimelineRowView()
  ]

  let onTapLabelSubject = BehaviorSubject<UIAlertAction?>(value: nil)

  // MARK: - UI Elements Properties
  var scrollView = UIScrollView()
  var scrollContainer = UIView()

  lazy var todoStatusBadge = TLBadge(status: .todo, variant: .colored)

  lazy var motivationText = TLTypography(title: "", fontSize: .body, weight: .regular)
  lazy var textChangeTodoStatusButton = TLTypography(title: "Update progress", fontSize: .body, colour: TLColours.Primary.p300.color, weight: .bold )

  lazy var startDateLabel = TLCustomDateTextField(label: "", color: TLColours.TodoPalette.green.color)
  lazy var startDatePicker = UIDatePicker()
  lazy var endDateLabel = TLCustomDateTextField(label: "", color: TLColours.TodoPalette.orange.color)
  lazy var endDatePicker = UIDatePicker()

  lazy var descriptionTextInput = TLTextAreaView()
  lazy var todoNameTextInput = UITextField()

  lazy var simpleTimelineView = TLSimpleTimelineView()

  lazy var noteIcon = UIImage(named: "note.text")
  lazy var personsIcon = UIImage(named: "person.2.fill")
  let timelineIcon = UIImageView(image: UIImage(systemName: "calendar.day.timeline.left"))
  let startDateCalendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))
  let endDateCalendarIcon =  UIImageView(image: UIImage(systemName: "calendar"))
  let simpleTimelineIcon = UIImageView(image: UIImage(systemName: "line.3.horizontal.decrease"))

  let statusAlert = UIAlertController(title: "Update status", message: "This will Change the status of the todo", preferredStyle: .actionSheet)

  // MARK: - Lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()
    configuration()
    buildLayout()
    createBindingViewWithViewModel()
  }

  private func configuration(){
    let shareButton = UIBarButtonItem(title: "square.and.arrow.up")
    let deleteButton = UIBarButtonItem(systemItem: .trash)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))

    navigationController?.navigationItem.leftBarButtonItems = [shareButton, deleteButton]
    self.view.backgroundColor = .systemBackground

    self.view.addGestureRecognizer(tapGesture)
  }
}



// MARK: - UI
extension TodoDetailsVC {

  func scrollViewConfig(){
    let scrollContentGuide = scrollView.contentLayoutGuide
    let scrollFrameGuide = scrollView.frameLayoutGuide
    let heightSize = (UIScreen.main.bounds.height * 0.1) + UIScreen.main.bounds.height

    constraints += [
      scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),


      scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
      scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
      scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor, constant: padding16),
      scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor, constant: -padding16),

      scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: padding16),
      scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant:  -padding16),
      scrollContainer.heightAnchor.constraint(equalToConstant: heightSize )
    ]
  }

  func motivationTextConfig(){
    constraints += [
      motivationText.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: TLSpacing
        .s16.size),
      motivationText.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: ICON_SIZE + TLSpacing.s16.size),
      motivationText.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -TLSpacing.s16.size)
    ]
  }

  func todoNameRowConfig(){
    self.todoNameTextInput.placeholder = "Write something like Glopi is cool"
    self.scrollContainer.addSubview(todoNameTextInput)

    constraints += [
      todoNameTextInput.topAnchor.constraint(equalTo: motivationText.topAnchor, constant: sectionSpacing),
      todoNameTextInput.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: ICON_SIZE + TLSpacing.s16.size),
      todoNameTextInput.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -TLSpacing.s16.size)
    ]
  }

  func todoDetailsRowConfig(){
    self.timelineIcon.tintColor = .label
    self.descriptionTextInput.text = "Write a cool text"

    UIHelper.setIconSizeContraints(for: self.timelineIcon, size: ICON_SIZE)

    constraints += [
      timelineIcon.topAnchor.constraint(equalTo: todoNameTextInput.bottomAnchor, constant: sectionSpacing),
      timelineIcon.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
      descriptionTextInput.topAnchor.constraint(equalTo: todoNameTextInput.bottomAnchor, constant: sectionSpacing),
      descriptionTextInput.leadingAnchor.constraint(equalTo: timelineIcon.trailingAnchor, constant: TLSpacing.s16.size),
      descriptionTextInput.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -TLSpacing.s16.size),
      descriptionTextInput.heightAnchor.constraint(equalToConstant: 36)
    ]
  }

  func startDateRowConfig(){
    self.startDateCalendarIcon.tintColor = .label
    self.startDatePicker.datePickerMode = .date
    self.startDatePicker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)

    self.startDateLabel.inputView = self.startDatePicker

    UIHelper.setIconSizeContraints(for: self.startDateCalendarIcon, size: ICON_SIZE)

    constraints += [
      self.startDateCalendarIcon.topAnchor.constraint(equalTo: descriptionTextInput.bottomAnchor, constant: sectionSpacing),
      self.startDateCalendarIcon.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
      startDateLabel.leadingAnchor.constraint(equalTo: self.startDateCalendarIcon.trailingAnchor, constant: TLSpacing.s16.size),
      startDateLabel.centerYAnchor.constraint(equalTo: self.startDateCalendarIcon.centerYAnchor),
    ]

  }

  func _createTimeline(){
    self.simpleTimelineIcon.tintColor = .label
    UIHelper.setIconSizeContraints(for: self.simpleTimelineIcon, size: ICON_SIZE)
    simpleTimelineView.buildTimeline(with: timelineRowViews)

    constraints += [
      simpleTimelineView.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: sectionSpacing),
      simpleTimelineView.leadingAnchor.constraint(equalTo: self.simpleTimelineIcon.trailingAnchor, constant: TLSpacing.s16.size),
      simpleTimelineView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: TLSpacing.s16.size),
      self.simpleTimelineIcon.centerYAnchor.constraint(equalTo: simpleTimelineView.centerYAnchor),
      self.simpleTimelineIcon.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
    ]
  }

  func endDateRowConfig() {
    self.endDateCalendarIcon.tintColor = .label

    self.endDatePicker.datePickerMode = .date
    self.endDatePicker.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)

    self.endDateLabel.inputView = self.endDatePicker

    UIHelper.setIconSizeContraints(for: self.endDateCalendarIcon, size: ICON_SIZE)

    constraints += [
      self.endDateCalendarIcon.centerYAnchor.constraint(equalTo: endDateLabel.centerYAnchor),
      self.endDateCalendarIcon.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
      endDateLabel.leadingAnchor.constraint(equalTo: self.endDateCalendarIcon.trailingAnchor, constant: TLSpacing.s16.size),
      endDateLabel.topAnchor.constraint(equalTo: simpleTimelineView.bottomAnchor, constant: sectionSpacing)
    ]
  }

  func todoStatusButtonConfig() {
    self.textChangeTodoStatusButton.textAlignment = .center
    self.textChangeTodoStatusButton.isUserInteractionEnabled = true

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerMenu))
    textChangeTodoStatusButton.addGestureRecognizer(tapGesture)

    constraints += [
      self.textChangeTodoStatusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -self.padding16),
      self.textChangeTodoStatusButton.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor)
    ]
  }

  func todoStatusBadgeConfig(){
    constraints += [
      todoStatusBadge.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: sectionSpacing),
      todoStatusBadge.leadingAnchor.constraint(equalTo: endDateLabel.leadingAnchor),
    ]
  }

  func setupLayout() {
    self.scrollViewConfig()
    self.motivationTextConfig()
    self.todoNameRowConfig()
    self.todoDetailsRowConfig()
    self.startDateRowConfig()
    self._createTimeline()
    self.endDateRowConfig()
    self.todoStatusButtonConfig()
    self.todoStatusBadgeConfig()

    NSLayoutConstraint.activate(constraints)
  }

  func resetAutoLayout() {
    self.motivationText.translatesAutoresizingMaskIntoConstraints = false
    self.todoNameTextInput.translatesAutoresizingMaskIntoConstraints = false
    self.descriptionTextInput.translatesAutoresizingMaskIntoConstraints = false
    self.startDateLabel.translatesAutoresizingMaskIntoConstraints = false
    self.endDateLabel.translatesAutoresizingMaskIntoConstraints = false
    self.simpleTimelineView.translatesAutoresizingMaskIntoConstraints = false
    self.textChangeTodoStatusButton.translatesAutoresizingMaskIntoConstraints = false
    self.todoStatusBadge.translatesAutoresizingMaskIntoConstraints = false
    self.scrollContainer.translatesAutoresizingMaskIntoConstraints = false
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.timelineIcon.translatesAutoresizingMaskIntoConstraints = false
    self.startDateCalendarIcon.translatesAutoresizingMaskIntoConstraints = false
    self.endDateCalendarIcon.translatesAutoresizingMaskIntoConstraints = false
    self.simpleTimelineIcon.translatesAutoresizingMaskIntoConstraints = false
  }

  func addSubViewsToScreen(){
    self.view.addSubview(scrollView)
    self.scrollView.addSubview(scrollContainer)
    self.scrollContainer.addSubview(self.timelineIcon)
    self.scrollContainer.addSubview(motivationText)
    self.scrollContainer.addSubview(todoNameTextInput)
    self.scrollContainer.addSubview(descriptionTextInput)
    self.scrollContainer.addSubview(startDateLabel)
    self.scrollContainer.addSubview(endDateLabel)
    self.scrollContainer.addSubview(simpleTimelineView)
    self.scrollContainer.addSubview(textChangeTodoStatusButton)
    self.scrollContainer.addSubview(todoStatusBadge)
    self.scrollContainer.addSubview(self.startDateCalendarIcon)
    self.scrollContainer.addSubview(self.endDateCalendarIcon)
    self.scrollContainer.addSubview(self.simpleTimelineIcon)
  }

  func buildLayout() {
    self.resetAutoLayout()
    self.addSubViewsToScreen()
    self.setupLayout()
  }
}

// MARK: - Bindings
extension TodoDetailsVC {
  func createBindingViewWithViewModel() {
    let output = todoDetailsViewModel.bind(
      .init( todoTitle: todoNameTextInput.rx.text.orEmpty.asObservable(),
             todoDescription: descriptionTextInput.rx.text.orEmpty.asObservable(),
             onStartDateChange: startDateLabel.rx.text.orEmpty.asObservable(),
             onEndDateChange: endDateLabel.rx.text.orEmpty.asObservable(),
             updateProgress: onTapLabelSubject.asObservable()
           )
    )

    output.todoTitle
      .bind(to: todoNameTextInput.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.todoDescription
      .bind(to: descriptionTextInput.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.statusLabel
      .bind(to: todoStatusBadge.badgeStatus.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.startDateLabel
      .bind(to: startDateLabel.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.endDateLabel
      .bind(to: endDateLabel.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.motivationMessage
      .bind(to: motivationText.rx.text)
      .disposed(by: todoDetailsViewModel.bag)

    output.triggerUpdates
      .subscribe()
      .disposed(by: todoDetailsViewModel.bag)
  }
}

// MARK: Actions
extension TodoDetailsVC {
  @objc func viewWasTapped(gestureRecognizer: UITapGestureRecognizer) {
     view.endEditing(true)
   }

  @objc func endDateChanged(datePicker: UIDatePicker){
    DispatchQueue.main.async {
      self.endDateLabel.text = Date.dateFormatter(from: datePicker.date.timeIntervalSince1970 * 1000)
      self.view.endEditing(true)
    }
  }

  @objc func startDateChanged(datePicker: UIDatePicker){
    DispatchQueue.main.async {
      self.startDateLabel.text = Date.dateFormatter(from: datePicker.date.timeIntervalSince1970 * 1000)
      self.view.endEditing(true)
    }
  }


  @objc func triggerMenu() {
    let statusAlert = UIAlertController(title: "Update status",
                                        message: "This will Change the status of the todo",
                                        preferredStyle: .actionSheet)

    let actions = [
      UIAlertAction(title: "Todo", style: .default, handler: {action in
        self.onTapLabelSubject.onNext(action)
      }),
      UIAlertAction(title: "In Progress", style: .default, handler: {action in
        self.onTapLabelSubject.onNext(action)
      }),
      UIAlertAction(title: "Completed", style: .default, handler: {action in
        self.onTapLabelSubject.onNext(action)
      }),
      UIAlertAction(title: "On Hold", style: .default, handler: {action in
        self.onTapLabelSubject.onNext(action)
      }),
      UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
        self.onTapLabelSubject.onNext(action)
      })
    ]

    for action in actions {
      statusAlert.addAction(action)
    }

    present(statusAlert, animated: true, completion: nil)
  }
}

#Preview {
  TodoDetailsVC()
}

