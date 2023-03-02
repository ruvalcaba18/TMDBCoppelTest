//
//  ViewController.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: LoginViewToPresenter?
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let mrRobotImage = UIImageView(image: UIImage(named: "robot"))
    let loginButton = UIButton()
    let errorLabel = UILabel()
    let activityIndicatorView = UIActivityIndicatorView()
    let ownerView = UIView()
    let vc = MovieRouter.createMovieModule()
    let passwordToggleIcon = UIButton(type: .custom)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        usernameTextField.accessibilityIdentifier = "usernameTextField"
        passwordTextField.accessibilityIdentifier = "password"
        mrRobotImage.accessibilityIdentifier = "mrRobotImage"
        loginButton.accessibilityIdentifier = "loginButton"
        errorLabel.accessibilityIdentifier = "errorLabel"
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: "01516a").cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Actions
    @objc public func loginButtonTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        self.presenter?.isUsernameAndPasswordValid(username, password)
        view.addSubview(ownerView)
        view.addSubview(activityIndicatorView)
        startActivityIndicator(loader: activityIndicatorView, ownerView: ownerView)
     
    }
    
    @objc public func togglePasswordVisibility(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye.fill")
        sender.setImage(buttonImage, for: .normal)
    }
    
    // MARK: - UI
    private func setUpUI() {
        
        self.view.backgroundColor = .black
        mrRobotImage.contentMode = .scaleAspectFill
        mrRobotImage.clipsToBounds = true
        view.addSubview(mrRobotImage)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        passwordToggleIcon.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordToggleIcon.tintColor = .gray
        passwordToggleIcon.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        view.addSubview(passwordToggleIcon)
        
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        errorLabel.textColor = .red
        view.addSubview(errorLabel)
        
        setUpConstraints()
        
        loginButton.isEnabled = false
        loginButton.backgroundColor = .gray
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    private func setUpConstraints()
    {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordToggleIcon.translatesAutoresizingMaskIntoConstraints = false
        mrRobotImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mrRobotImage.topAnchor.constraint(equalTo: view.topAnchor),
            mrRobotImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mrRobotImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mrRobotImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            usernameTextField.topAnchor.constraint(equalTo: mrRobotImage.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordToggleIcon.leadingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            passwordToggleIcon.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordToggleIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordToggleIcon.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
#if DEBUG
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(hex: "1ca703")
#else
        if newText.isEmpty {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .gray
        } else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(hex: "1ca703")
        }
#endif
        return true
    }
}


//  MARK: - MoviePresenterToView
extension ViewController: LoginPresenterToView {
    
    func setIsUsernameAndPasswordValid(_ correctUser: Bool, _ correctPassword: Bool) {
        
        TMDBSDK.shared.environment = .basic
    
        if correctUser && correctPassword {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                
                self?.navigationController?.modalPresentationStyle = .popover
                self?.navigationController?.pushViewController(self!.vc, animated: true)
                self?.dismiss(animated: true, completion: nil)
                self?.stopActivityIndicator(loader: self!.activityIndicatorView, ownerView: self!.ownerView)
            }
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                self?.stopActivityIndicator(loader: self!.activityIndicatorView, ownerView: self!.ownerView)
                self?.errorLabel.text = "Incorrect username or password"
            }
            
        }
    }
    
}
