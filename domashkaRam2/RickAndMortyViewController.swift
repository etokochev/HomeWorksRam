//
//  RickAndMortyViewController.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 6/16/23.
//

import UIKit
import SnapKit

class RickAndMortyViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(
            width: view.frame.width,
            height: 90)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.dataSource = self
        view.delegate = self
        view.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID
        )
        return view
    }()
    
    private let networkService = NetworkService()
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCharacters()
        
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func fetchCharacters() {
        Task {
            do {
                let response = try await networkService.fetchCharacters()
                self.characters = response.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("error")
            }
        }
    }
}

extension RickAndMortyViewController: UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.reuseID,
            for: indexPath
        ) as! CharacterCollectionViewCell
        let model = characters[indexPath.item]
        cell.display(item: model)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}








