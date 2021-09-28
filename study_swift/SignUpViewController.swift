//
//  SignUpViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/23.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    private let viewModel: UserViewModel = UserViewModel()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButtonDisable()

        idTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        nickNameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setDismissKeyboard()
    }
    
    @objc func keyboardShown(notification: Notification) {
        // Too high from register button so we can't see this field
        if (idTextField.isEditing) { return }
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let registerButtonMaxY = registerButton.frame.maxY
        let distance = registerButtonMaxY - keyboardMinY + 20
        
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = transform
            })
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }

    @IBAction func onClickRegister(_ sender: Any) {
        if (isNotToRegister()) {
            print("no")
            return;
        }
        let id: String = idTextField.text!
        let email: String = emailTextField.text!
        let password: String = passwordTextField.text!
        let name: String = nameTextField.text!
        let nickname: String = nickNameTextField.text!
        let dto: UserViewModel.createUserDto = UserViewModel.createUserDto.init(
            id: id,
            email: email,
            password: password,
            name: name,
            nickname: nickname
        )
        registerUser(dto: dto)
        login(dto: dto)
        presentHomeView()
        
    }
    
    @IBAction func onClickAlreadyRegistered(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LogIn") as! LogInViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    private func isNotToRegister() -> Bool {
        return hasEmptyField() || isNotEmail() || passwordLengthNotEnough()
    }
    
    private func hasEmptyField() -> Bool {
        let idIsEmpty: Bool = idTextField.text?.isEmpty ?? true
        let emailIsEmpty: Bool = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty: Bool = passwordTextField.text?.isEmpty ?? true
        let nameIsEmpty: Bool = nameTextField.text?.isEmpty ?? true
        let nicknameIsEmpty: Bool = nickNameTextField.text?.isEmpty ?? true
        
        return idIsEmpty || emailIsEmpty || passwordIsEmpty || nameIsEmpty || nicknameIsEmpty
    }
    
    private func isNotEmail() -> Bool {
        return !String(emailTextField.text ?? "").isValidEmail
    }
    
    private func passwordLengthNotEnough() -> Bool {
        return String(passwordTextField.text ?? "").count < 8
    }

    private func registerUser(dto: UserViewModel.createUserDto) -> Void {
        self.viewModel.registerUser(dto: dto)
    }
    
    private func login(dto: UserViewModel.createUserDto) {
        let viewModel: LogInViewModel = LogInViewModel()
        let accessToken: String = viewModel.login(dto: LogInViewModel.logInDto.init(email: dto.email, password: dto.password))
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        print("セットされたやーつ" + token)
    }
    
    private func presentHomeView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBarController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func setDismissKeyboard() {
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isNotToRegister() {
            registerButtonDisable()
            return
        }
        
        registerButtonAnable()
    }
    
    private func registerButtonDisable() -> Void {
        registerButton.isEnabled = false
        registerButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
    }
    
    private func registerButtonAnable() -> Void {
        registerButton.isEnabled = true
        registerButton.backgroundColor = UIColor.rgb(red: 255, green: 141, blue: 0)
    }
}

extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
}
