import Foundation
import UIKit
import RxSwift
import RxCocoa


struct LoginViewModelInput {
  var username:  Observable<String?>
  var password:  Observable<String?>
  var didTap: Observable<Void>
}

struct LoginViewModelOutput {
   var enableLoginButton: Observable<Bool>
   var showLoginErrorModal: Observable<Bool>
   var loginIsSuccess:  Observable<Bool>
}

class LoginViewModel {
  
  var bag = DisposeBag()

  func bind(_ input: LoginViewModelInput) -> LoginViewModelOutput {

    let enableLoginButton = Observable.combineLatest(input.username, input.password) {
      guard let username = $0, let password = $1 else {return false}
      return username.count > 5 && password.count > 5
    }.map {$0}

    let usernameAndPasswordHasChanged = Observable.combineLatest(input.username, input.password).map { _ in
      false
    }

    let loginIsSuccess = input.didTap.withLatestFrom(Observable.combineLatest(input.username, input.password)).flatMap { (username, pass) in
      guard let username = username, let password = pass else {return Observable.just(false)}
      return self.onSignInWith(username: username, password: password ).catchAndReturn(false)
    }

    let showLoginErrorModal = Observable.merge(loginIsSuccess.map{ !$0 }, usernameAndPasswordHasChanged)

    return .init(enableLoginButton: enableLoginButton, showLoginErrorModal: showLoginErrorModal, loginIsSuccess: loginIsSuccess )
  }

  func onSignInWith(username: String, password: String) -> Observable<Bool> {
    return Observable.create { observer in
      let task = Task {
        do {
          let _ =  try await  NetworkManager.shared.signInWith(email: username , password: password )
          observer.on(.next(true))
          observer.on(.completed)

        } catch {
          observer.on(.error(error))
        }
      }
      return Disposables.create {
        task.cancel()
      }

    }
  }
}


