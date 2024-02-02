import UIKit
import SwiftUI
import FirebaseAuth

class LoginVC: UIViewController {
    let screenWidth = UIScreen.main.bounds.width,
        screenHeight = UIScreen.main.bounds.height / 2
    
    let loginFormContainer: UIView = TLLoginFormView(frame: .zero)
    
    let topBackground: UIView = {
       let uiView = UIView()
        uiView.backgroundColor = TLColours.Primary.p300.color
        
       return uiView
    }()
    
    let timelinTextLogo = TLTypography(title: "Timelin", fontSize: .largeTitle, colour: TLColours.Neutrals.white.color, weight: .bold)
    let usernameTextInput = TLTextInput()
    let passwordTextInput = TLTextInput()
    let loginButton = TLButton(label: "Login", variant: .primary, size: .lg)
    let ctaText = TLTypography(title: "Don't have an account", fontSize: .body)
    let ctaLoginText = TLTypography(title: "Create account", fontSize: .body, colour: TLColours.Primary.p300.color,weight: .bold )
    
    var textStack: UIStackView!
    var formStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupKeyboardAvoidanceView()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(loginFormContainer)
        view.addSubview(topBackground)
        view.sendSubviewToBack(topBackground)
        
        loginButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        ctaLoginText.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToSignUpScreen))
        ctaLoginText.addGestureRecognizer(tapGesture)
        
        
        topBackground.addSubview(timelinTextLogo)
        
        setupTextFields()
        configureTextStack()
        configureFormStack()
        setupLayout()
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
    
        NSLayoutConstraint.activate([
                loginFormContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loginFormContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                loginFormContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                loginFormContainer.heightAnchor.constraint(equalToConstant: screenHeight),
                // formStack
                formStack.topAnchor.constraint(equalTo: loginFormContainer.topAnchor, constant: TLSpacing.s32.size),
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
                topBackground.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
                
                //Timelin Text Logo
                timelinTextLogo.centerXAnchor.constraint(equalTo: topBackground.centerXAnchor),
                timelinTextLogo.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor)
            ])
    
        usernameTextInput.setupConstraints(in: self.formStack, spacing: TLSpacing.s16.size)
        passwordTextInput.setupConstraints(in: self.formStack, spacing: TLSpacing.s16.size)
    }
    
    @objc func handleSignIn(){
        NetworkManager.shared.signInWith(email: usernameTextInput.text ?? "", password: passwordTextInput.text ?? "") { result in
            switch result {
                case .success(_):
                    UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionFlipFromLeft,animations: {
                        let tabBarNavigator = TabBarNavigator()
                        self.view.window?.rootViewController = tabBarNavigator
                    })
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @objc func goToSignUpScreen(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.2,
                       animations:{
                self.ctaLoginText.alpha = 0.5
         }
        ) {
            _ in
            UIView.animate(withDuration: 0.2) {
                self.ctaLoginText.alpha = 1.0
            }
        }
    }
}

#Preview {
    LoginVC()
}
