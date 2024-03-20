import Foundation
import RxSwift
import RxCocoa

class TodoDetailsViewModel: TodoDetailsViewModelProtocol {
  struct TodoDetailsViewModelInput{
   var todoTitle: Observable<String>
   var todoDescription: Observable<String>
   var onStartDateChange: Observable<String>
   var onEndDateChange: Observable<String>
   var updateProgress: Observable<UIAlertAction?>
 }

  struct TodoDetailsViewModelOutput{
   var todoTitle: Observable<String>
   var todoDescription: Observable<String>
   var textInputHeight: Observable<Int>
   var statusLabel: Observable<String>
   var startDateLabel: Observable<String>
   var endDateLabel: Observable<String>
   var motivationMessage: Observable<String>
   var triggerUpdates: Observable<()>
 }

  var bag = DisposeBag()
  let maxLength: Int = 50

  func bind(_ input: TodoDetailsViewModelInput) -> TodoDetailsViewModelOutput {
    let title = input.todoTitle
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .map { [weak self] value in
        guard let self = self else { return "" }
        return String(value.prefix(self.maxLength - 20))
      }
      .asObservable()

    let todoDescription = input.todoDescription
      .map { [weak self] value in
        guard let self = self else { return "" }
        return String(value.prefix(self.maxLength * 3))
      }
      .asObservable()

    let maxTextInputHeight = todoDescription.flatMap { value in
      return Observable.just(value.count)
    }
      .asObservable()

    let startDateLabel = input.onStartDateChange.map { $0 }

    let endDateLabel = input.onEndDateChange.map { $0 }

    let motivationMessage = endDateLabel
      .flatMap { (timestamp) in
      return self.generateMotivationMessage(timestamp)
      }
      .map { value in
      return value
    }

    let statusLabel =  input.updateProgress
     .flatMap { action in
       return self.updateProgress(action)
    }
     .map { value in
      value
     }

    let triggerUpdates = Observable.combineLatest(input.todoTitle, input.todoDescription, input.onStartDateChange, input.onEndDateChange, statusLabel)
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .flatMap { (title, description, startDate, endDate, statusLabel) in

        let dictionary = ["todo": title,
                          "description": description,
                          "startDate": Date.timestamp(from: startDate),
                          "endDate": Date.timestamp(from: endDate),
                          "status": statusLabel
                        ]

        return self.updateTodo("id", with: dictionary).catchAndReturn(())
      }
      .map { val in
        return val
      }


    return .init(todoTitle: title,
                 todoDescription: todoDescription,
                 textInputHeight: maxTextInputHeight,
                 statusLabel: statusLabel,
                 startDateLabel: startDateLabel,
                 endDateLabel: endDateLabel,
                 motivationMessage: motivationMessage,
                 triggerUpdates: triggerUpdates
    )
  }

  func generateMotivationMessage(_ timestamp: String) -> Observable<String> {
     let endDateTimestamp = Date.timestamp(from: timestamp)

    let currentDate =  Date(timeIntervalSince1970: Date.now.timeIntervalSince1970)
    let endDate = Date(timeIntervalSince1970: endDateTimestamp / 1000)

    let timeInterval = endDate.timeIntervalSince(currentDate)
    let daysDifference = timeInterval / 86400

    if(daysDifference < 15) {
      return Observable.just("Time is running out")
    } else if (daysDifference > 15 && daysDifference < 30 ){
      return Observable.just("You are on track")
    }else if (daysDifference > 30 && daysDifference < 45 ){
      return Observable.just("A lot of time left")
    }

    return Observable.just("You are doing well")
  }

  func updateProgress(_ action: UIAlertAction?) -> Observable<String> {
    guard let action = action else { return Observable.just("TODO") }

    switch action.title {
    case "Todo":
      return Observable.just("Todo".uppercased())
    case "In Progress":
      return Observable.just("In Progress".uppercased())
    case "On Hold":
      return Observable.just("On Hold".uppercased())
    case "Completed":
      return Observable.just("Completed".uppercased())
    default:
      return Observable.just("")
    }
  }

  func updateTodo(_ id: String, with data: [String: Any]) -> Observable<()>{
    return Observable.create { observer in
      let task = Task {
        do {
          _ = try await NetworkManager.shared.updateTodoWith(id: id, with: data)
          observer.on(.next(()))
          observer.on(.completed)

        } catch {
          observer.on(.error((error)))
          print(error)
        }
      }

      return Disposables.create {
        task.cancel()
      }
    }
  }

}
