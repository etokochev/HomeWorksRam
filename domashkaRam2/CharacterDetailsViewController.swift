//
//  CharacterDetailsViewController.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/2/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var name = UILabel()
    
    override func viewDidLoad() {
        setupConstraints()
        view.backgroundColor = .white
    }
    
    func setupConstraints(){
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalTo(150)
            make.trailing.equalToSuperview().inset(150)
            make.height.equalTo(100)
            
        }
        view.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(400)
            make.edges.equalToSuperview().offset(200)
        }
    }
}
