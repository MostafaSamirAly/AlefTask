//
//  HomeViewModel.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//


import RxSwift

class HomeViewModel: NSObject {
    
    let products: PublishSubject<[Product]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let errorSubject: PublishSubject<Error> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    func fetchProducts(for title: String) {
        self.loading.onNext(true)
        Api().fireRequestWithSingleResponse(urlConvertible: ProductApi.getProducts(title), mappingClass: BaseModel<[Product]>.self).subscribe(onNext: { [weak self] response in
            self?.loading.onNext(false)
            self?.products.onNext(response.data ?? [])
            CoreDataHelper.shared.insert(products: response.data ?? [])
        }, onError: { [weak self] erorrResponse in
            self?.loading.onNext(false)
            self?.errorSubject.onNext(erorrResponse)
            self?.products.onNext(CoreDataHelper.shared.getProductsFromCoreData())
        }).disposed(by: disposeBag)
    }
}
