//
//  SplashViewController.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import UIKit

class SplashViewController: UIViewController {

    private let keychain = KeyChainStorage.shared
    private let encoder = JSONDecoder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        if let data = keychain.read(
            with: Constants.Keychain.service,
            Constants.Keychain.account),
           
            let date = try? decoder.decode(Date.self, from: data),
           date > Date() {
            let vc = RickAndMortyViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        } else {
            let vc = UIStoryboard(name: "Main",
                                  bundle: nil).instantiateViewController(
                                    withIdentifier: "ViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}
