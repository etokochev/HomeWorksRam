//
//  ProductVC.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/23/23.
//

import UIKit

class ProductVC: UIViewController {
    
    @IBOutlet private weak var deliveryCollectionView: UICollectionView!
    @IBOutlet private weak var productSearchBar: UISearchBar!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var amountOpenStoresLabel: UILabel!
    @IBOutlet private weak var productTableView: UITableView!
    @IBOutlet private weak var bottomTabBar: UITabBar!
    
    private let networkService = NetworkService()
    private let categories = [
        Category(CategoryProductImage: "takeaways",
                 CategoryProductName: "Takeaways"),
        
        Category(CategoryProductImage: "grocery",
                 CategoryProductName: "Grocery"),
        
        Category(CategoryProductImage: "convenience",
                 CategoryProductName: "Convenience"),
        
        Category(CategoryProductImage: "pharmacy",
                 CategoryProductName: "Pharmacy")
    ]
    private var products: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
        configureTableView()
        configureCollectionView()
        fetch()
    }
    
    private func fetchProduct() {
        networkService.productRequest { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetch() {
        Task {
            do {
                let response = try await networkService.productRequest()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productTableView.reloadData()
                }
            } catch {
                //alert
            }
        }
    }
    
    private func configureTableView() {
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(
            UINib(nibName: ProductTableViewCell.nibName,
                  bundle: nil),
            forCellReuseIdentifier: ProductTableViewCell.reuseId)
    }
    
    private func configureCollectionView() {
        deliveryCollectionView.dataSource = self
        categoryCollectionView.dataSource = self
        
        deliveryCollectionView.delegate = self
        categoryCollectionView.delegate = self
        
        deliveryCollectionView.register(
            UINib(
                nibName: DeliveryCell.nibname,
                bundle: nil),
            forCellWithReuseIdentifier: DeliveryCell.reuseID)
        
        categoryCollectionView.register(
            UINib(
                nibName: CategoryCell.nibname,
                bundle: nil),
            forCellWithReuseIdentifier: CategoryCell.reuseID)
    }
}

extension ProductVC:
    UITableViewDataSource,
    UITableViewDelegate{
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            products.count
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductTableViewCell.reuseId,
                for: indexPath) as! ProductTableViewCell
            
            let model = products[indexPath.row]
            cell.display(item: model)
            return cell
        }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
            280
        }
}

extension ProductVC: UICollectionViewDelegateFlowLayout,
                     UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == categoryCollectionView {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryCell.reuseID,
                    for: indexPath) as! CategoryCell
                
                let model = categories[indexPath.row]
                cell.display(item: model)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DeliveryCell.reuseID
                    , for: indexPath) as! DeliveryCell
                return cell
            }
            
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 80, height: 150)
        } else {
            return CGSize(width: 110, height: 40)
        }
    }
}
