//
//  AuthorizationViewController.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/4/23.
//

import UIKit
import SnapKit
import FirebaseAuth


class AuthorizationViewController: UIViewController {
    
    let phoneNumberTextField: UITextField = {
        let phoneNumberTF = UITextField()
        phoneNumberTF.backgroundColor = .gray
        phoneNumberTF.placeholder = "Input Your Phone Number"
        phoneNumberTF.layer.cornerRadius = 15
        return phoneNumberTF
    }()
    
    let verificationTextField: UITextField = {
        let verificationTF = UITextField()
        verificationTF.backgroundColor = .gray
        verificationTF.placeholder = "Input Your Code"
        verificationTF.layer.cornerRadius = 15
        return verificationTF
    }()
    
    let sumbitButton: UIButton = {
        let checkButton = UIButton()
        checkButton.backgroundColor = .red
        checkButton.setTitle("AUTH", for: .normal)
        checkButton.layer.cornerRadius = 15
        checkButton.addTarget(AuthorizationViewController.self, action: #selector(sendTap(sender: )), for: .touchUpInside)
        return checkButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-50)
        }
        
        view.addSubview(verificationTextField)
        
        verificationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
        }
        
        view.addSubview(sumbitButton)
        
        sumbitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(verificationTextField.snp.bottom).offset(20)
        }
    }
    
    private let authApi = AuthorizationManager()
    
    @objc private func sendTap(sender: UIButton) {
        guard let phone = phoneNumberTextField.text, !phone.isEmpty else {
            return
        }
        authApi.tryToSendSMSCode(phoneNumber: phone) { result in
            switch result {
            case .success:
                print("Код был отправлен")
            case .failure(let error):
                print("Код не был отправлен \(error)")
                break
            }
        }
    }
    
    @objc private func sendVerificationCodeTap() {
        guard let vCode = verificationTextField.text,
              !vCode.isEmpty else {
            return
        }
        authApi.tryToSignIn(smsCode: vCode) { result in
            if case .success = result {
                print("Success")
                self.present(SplashViewController(), animated: true)
            } else {
                
            }
        }
    }
}

class AuthorizationManager {
    private let auth = Auth.auth()
    private let provider = PhoneAuthProvider.provider()
    private var verificationID: String?
    private let keychain = KeyChainStorage.shared
    private let userdefault = UserDefaults.standard
    
    /// Метод, для того чтобы отправлять номер телефона в Firebase
    /// - Parameters:
    ///   - phoneNumber: Номер теелфона
    ///   - completion: Получаем succes с verificationID
    func tryToSendSMSCode(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(.failure(error!))
                return
            }
            
            self.userdefault.set(verificationID, forKey: "vID")
            completion(.success(()))
        }
    }
    
    
    /// Метод для верификации смс кода
    /// - Parameters:
    ///   - smsCode: на телефоне
    ///   - completion: result
    func tryToSignIn(smsCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let verificationID = userdefault.string(forKey: "vID") else {
            fatalError()
        }
        
        let credential = provider.credential(withVerificationID: verificationID, verificationCode: smsCode)
        
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            guard let _ = result, error == nil else {
                completion(.failure(error!))
                return
            }
            
            if self.auth.currentUser != nil {
                self.saveSession()
                completion(.success(()))
            }
        }
    }
    
    private func saveSession() {
        let minuteLater = Calendar.current.date(byAdding: .second, value: 60, to: Date())!
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let data = try! encoder.encode(minuteLater)
        self.keychain.save(data, service: Constants.Keychain.service, account: Constants.Keychain.account)
    }
}
