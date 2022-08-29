//
//  RecaptchaViewController.swift
//  Scratchdemo
//
//  Created by Mac on 31/05/22.
//

import UIKit
import ReCaptcha
import WebKit

class RecaptchaViewController: UIViewController {
    
   // private var reCAPTCHAViewModel: ReCAPTCHAViewModel?
    
    @IBOutlet weak var recaptchaLbl: UILabel!
    @IBOutlet weak var recaptchaText: UITextField!
    private var recaptcha: ReCaptcha?
    private var locale: Locale = Locale(identifier: "fr-FR")
    private var endpoint = ReCaptcha.Endpoint.default
    var captchaGenerator = CaptchaGenerator()

    override func viewDidLoad() {
            super.viewDidLoad()
        recaptchaLbl.attributedText = captchaGenerator.generate()
//        do {
//                  recaptcha = try ReCaptcha(apiKey:"6LedBDUgAAAAAB8VoUr1gLaUffJBnnzIeHJbCqSF" , baseURL: URL(string: "http://user.bitconia.com"), endpoint: .default, locale: locale)
//                }
//             catch {
//                  print("error")
//                }
//             recaptcha?.configureWebView { [weak self] webview in
//                        webview.frame = self?.view.bounds ?? CGRect.zero
//                    }
//             recaptcha?.forceVisibleChallenge = true
//            let viewModel = ReCAPTCHAViewModel(
//                siteKey: "your_site_key",
//                url: URL(string: "https://yourdomain.com")!
//            )
//
//            viewModel.delegate = self
//
//            let vc = ReCAPTCHAViewController(viewModel: viewModel)
//
//            // Optional: present the ReCAPTCHAViewController so you have a navigation bar
//            let nav = UINavigationController(rootViewController: vc)
//
//            // Keep a reference to the View Model so we can be alerted when the user
//            // solves the CAPTCHA.
//            reCAPTCHAViewModel = viewModel
//
//            present(nav, animated: true)
        }
    
    
    
    @IBAction func reloadBtnAct(_ sender: Any) {
        recaptchaLbl.attributedText = captchaGenerator.generate()
    }
    
    @IBAction func submitBtnAct(_ sender: Any) {
       let correct = captchaGenerator.isMatched(text:recaptchaText.text ?? "",inCaseSensitive: true)
        if correct {
            validate()
        }else{
            recaptchaLbl.attributedText = captchaGenerator.generate()
        }
        
    }
    @IBAction func loginButtonTapped() {
        validate()
    }
    
    func validate(){
        recaptcha?.validate(on: view, resetOnError: true, completion: { (ReCaptchaResult) in
            switch ReCaptchaResult {
            case .error:
                print("error")
            case .token:
                print("error")
                //WHAT TO DO WITH THE TOKEN HERE?
//                guard let userName = self.userNameTextField.text, let password = self.passwordTextField.text else {
//                    return
//                }
//                self.authentificationPresenter.authenticate(userName: userName, password: password)
            }
        })
    }
    
}

extension RecaptchaViewController: ReCAPTCHAViewModelDelegate {
    func didSolveCAPTCHA(token: String) {
        print("Token: \(token)")
    }
}
