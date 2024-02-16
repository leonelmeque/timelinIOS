import UIKit
import SwiftUI
import FirebaseAuth
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
  let loginViewModel = LoginViewModel()
  let screenWidth = UIScreen.main.bounds.width,
      screenHeight = UIScreen.main.bounds.height / 2

  let loginFormContainer: UIView = TLLoginFormView(frame: .zero)

  let topBackground: UIView = {
     let uiView = UIView()
     uiView.backgroundColor = TLColours.Primary.p300.color
     uiView.translatesAutoresizingMaskIntoConstraints = false
     return uiView
  }()

  let timelinTextLogo = TLTypography(title: "Timelin", fontSize: .largeTitle, colour: TLColours.Neutrals.white.color, weight: .bold)
  let usernameTextInput = TLTextInput()
  let passwordTextInput = TLTextInput()
  let loginButton = TLButton(label: "Login", variant: .disabled, size: .lg)
  let ctaText = TLTypography(title: "Don't have an account", fontSize: .body)
  let ctaLoginText = TLTypography(title: "Create account", fontSize: .body, colour: TLColours.Primary.p300.color,weight: .bold )

  var textStack: UIStackView!
  var formStack: UIStackView!

  lazy var errorBanner = TLMiniBanner(title: "Opps something went wrong",
                                      description: "Check your username/password",
                                      variant: .error)

  override func viewDidLoad() {
      super.viewDidLoad()
      createBindingViewWithViewModel()
      configure()
      setupKeyboardAvoidanceView()
  }

  deinit {
      removeKeyboardObservers()
  }

  func configure(){
      navigationController?.isNavigationBarHidden = true

      view.backgroundColor = .systemBackground
      view.addSubview(loginFormContainer)
      view.addSubview(topBackground)
      view.sendSubviewToBack(topBackground)
      topBackground.addSubview(timelinTextLogo)

      configureGestures()
      setupTextFields()
      configureTextStack()
      configureFormStack()
      setupLayout()
  }

  func configureGestures(){
    ctaLoginText.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToSignUpScreen))
    ctaLoginText.addGestureRecognizer(tapGesture)
  }

  func setupTextFields(){
      usernameTextInput.placeholder = "Username"
      passwordTextInput.isSecureTextEntry = true
      passwordTextInput.placeholder = "Password"
  }

  func configureTextStack() {
      textStack = UIStackView(arrangedSubviews: [ctaText, ctaLoginText])
      textStack.axis = .horizontal
      textStack.spacing = TLSpacing.s4.size
  }

  func configureFormStack(){
      formStack = UIStackView(arrangedSubviews: [usernameTextInput, passwordTextInput, loginButton, textStack])

      formStack.translatesAutoresizingMaskIntoConstraints = false
      formStack.spacing = TLSpacing.s16.size
      formStack.axis = .vertical
      formStack.alignment = .center

      loginFormContainer.addSubview(formStack)
  }

  func setupLayout(){
     let padding = TLSpacing.s16.size
    errorBanner.translatesAutoresizingMaskIntoConstraints = false
     loginFormContainer.addSubview(errorBanner)
      NSLayoutConstraint.activate([
              loginFormContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              loginFormContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              loginFormContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
              loginFormContainer.heightAnchor.constraint(equalToConstant: screenHeight),
              //
              errorBanner.topAnchor.constraint(equalTo: loginFormContainer.topAnchor, constant: TLSpacing.s16.size),
              errorBanner.leadingAnchor.constraint(equalTo: loginFormContainer.leadingAnchor, constant: TLSpacing.s16.size),
              errorBanner.trailingAnchor.constraint(equalTo: loginFormContainer.trailingAnchor, constant: -TLSpacing.s16.size),
              errorBanner.heightAnchor.constraint(lessThanOrEqualToConstant: 0),
              // formStack
              formStack.topAnchor.constraint(equalTo: errorBanner.bottomAnchor, constant: TLSpacing.s16.size),
              formStack.leadingAnchor.constraint(equalTo: loginFormContainer.leadingAnchor),
              formStack.trailingAnchor.constraint(equalTo: loginFormContainer.trailingAnchor),
              formStack.bottomAnchor.constraint(equalTo: loginFormContainer.bottomAnchor),
              // login button
              loginButton.leadingAnchor.constraint(equalTo: self.formStack.leadingAnchor, constant: padding),
              loginButton.trailingAnchor.constraint(equalTo: self.formStack.trailingAnchor,
                                                   constant: -padding),
              // topBackground
              topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              topBackground.topAnchor.constraint(equalTo: view.topAnchor),
              topBackground.heightAnchor.constraint(equalToConstant: screenHeight),

              //Timelin Text Logo
              timelinTextLogo.centerXAnchor.constraint(equalTo: topBackground.centerXAnchor),
              timelinTextLogo.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor)
          ])


      usernameTextInput.setupConstraints(in: self.formStack, spacing: TLSpacing.s16.size)
      passwordTextInput.setupConstraints(in: self.formStack, spacing: TLSpacing.s16.size)
  }

  @objc func goToSignUpScreen(sender: UITapGestureRecognizer){
      UIView.animate(withDuration: 0.2,
                     animations: {
              self.ctaLoginText.alpha = 0.5
       }
      ) {
          _ in
          UIView.animate(withDuration: 0.2) {
              self.ctaLoginText.alpha = 1.0
          }
      }
  }

  func createBindingViewWithViewModel() {
    let output = loginViewModel.bind(.init(username: usernameTextInput.rx.text.asObservable(), password: passwordTextInput.rx.text.asObservable(), didTap: loginButton.rx.tap.asObservable()))

    output.enableLoginButton.bind(to: loginButton.rx.isEnabled).disposed(by: loginViewModel.bag)
    output.enableLoginButton.subscribe {value in
      if value {
        self.loginButton.setVariant(.primary)
      }else {
        self.loginButton.setVariant(.disabled)
      }
    }.disposed(by: loginViewModel.bag)

    output.loginIsSuccess.subscribe { event in
      switch event {
      case .next(let isSuccess):
        if isSuccess {
          DispatchQueue.main.async {
            let tabBarNavigator = TabBarNavigator()
            self.navigationController?.pushViewController(tabBarNavigator, animated: true)
            self.navigationController?.removeViewController(LoginVC.self)
          }
        }
      case .error(_):
        print("Error happened")
      case .completed:
        print("completed action")
      }
    }.disposed(by: loginViewModel.bag )

    output.showLoginErrorModal.subscribe { showBanner in
        if showBanner {
          DispatchQueue.main.async {
            self.errorBanner.heightAnchor.constraint(equalToConstant: 80).isActive = true
          }
        }
    }.disposed(by: loginViewModel.bag)
  }
}

#Preview {
    LoginVC()
}
