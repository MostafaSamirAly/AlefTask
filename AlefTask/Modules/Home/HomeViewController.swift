//
//  ViewController.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableView: UITableView!
    let disposeBag = DisposeBag()
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindLoading()
        bindError()
        bindTableView()
        bindSearchBar()
        viewModel.fetchProducts(for: "")
    }
    
    func bindError() {
        viewModel.errorSubject
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] error in
            self?.showAlert(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func bindTableView() {
        productsTableView.registerCellNib(cellClass: HomeTableViewCell.self)
        viewModel.products.bind(to: productsTableView.rx.items(cellIdentifier: String(describing: HomeTableViewCell.self), cellType: HomeTableViewCell.self)) {  (row,product,cell) in
            cell.configure(with: product)
            }.disposed(by: disposeBag)
    }
    
    func bindLoading() {
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    }
    
    func bindSearchBar() {
        searchBar.rx
           .searchButtonClicked
           .asDriver(onErrorJustReturn: ())
           .drive(onNext: { [weak searchBar, weak self]  in
              searchBar?.resignFirstResponder()
               self?.viewModel.fetchProducts(for: searchBar?.text ?? "")
           })
           .disposed(by: disposeBag)
    }

    @IBAction func sortImageTapped(_ sender: Any) {
    }
    
}

