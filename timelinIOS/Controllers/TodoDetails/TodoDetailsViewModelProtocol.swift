import Foundation
import RxSwift

struct TodoDetailsViewModelInput {
  var todoTItle: Observable<String>
  var todoDescription: Observable<String>
  var onStartDateChange: Observable<String>
  var onEndDateChange: Observable<String>
  var updateProgress: Observable<UIAlertAction?>
}

struct TodoDetailsViewModelOutput {
  var todoTitle: Observable<String>
  var todoDescription: Observable<String>
  var textInputHeight: Observable<Int>
  var statusLabel: Observable<String>
  var startDateLabel: Observable<String>
  var endDateLabel: Observable<String>
  var motivationMessage: Observable<String>
  var triggerUpdates: Observable<()>
}

protocol TodoDetailsViewModelProtocol {
  associatedtype Input = TodoDetailsViewModelInput
  associatedtype Output = TodoDetailsViewModelOutput

  var maxLength: Int { get }
  
  func bind(_ input: Input) -> Output

  func generateMotivationMessage(_ timestamp: String) -> Observable<String>
  func updateProgress(_ action: UIAlertAction?) -> Observable<String>
  func updateTodo(_ id: String, with data: [String: Any]) -> Observable<()>
}
