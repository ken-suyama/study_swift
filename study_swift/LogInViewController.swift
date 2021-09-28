//
//  LogInViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/24.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    private let viewModel: LogInViewModel = LogInViewModel()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logInButtonDisable()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setDismissKeyboard()
    }

    @objc func keyboardShown(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let logInButtonMaxY = logInButton.frame.maxY
        let distance = logInButtonMaxY - keyboardMinY + 20
        
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

    @IBAction func onClickLogIn(_ sender: Any) {
        if (isNotToLogIn()) {
            print("no")
            return;
        }
        let email: String = emailTextField.text!
        let password: String = passwordTextField.text!
        let dto: LogInViewModel.logInDto = LogInViewModel.logInDto.init(
            email: email,
            password: password
        )
        let accessToken: String = viewModel.login(dto: dto)
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        presentHomeView()
    }

    @IBAction func onClickNotRegistered(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func isNotToLogIn() -> Bool {
        return hasEmptyField() || isNotEmail() || passwordLengthNotEnough()
    }
    
    private func hasEmptyField() -> Bool {
        let emailIsEmpty: Bool = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty: Bool = passwordTextField.text?.isEmpty ?? true

        return emailIsEmpty || passwordIsEmpty
    }
    
    private func isNotEmail() -> Bool {
        return !String(emailTextField.text ?? "").isValidEmail
    }
    
    private func passwordLengthNotEnough() -> Bool {
        return String(passwordTextField.text ?? "").count < 8
    }

    private func presentHomeView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBarController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isNotToLogIn() {
            logInButtonDisable()
            return
        }
        
        logInButtonAnable()
    }
    
    private func logInButtonDisable() -> Void {
        logInButton.isEnabled = false
        logInButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
    }
    
    private func logInButtonAnable() -> Void {
        logInButton.isEnabled = true
        logInButton.backgroundColor = UIColor.rgb(red: 255, green: 141, blue: 0)
    }
}
