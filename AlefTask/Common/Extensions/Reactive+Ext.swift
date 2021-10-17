//
//  Reactive+Ext.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import RxSwift

extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.showLoadingView()
            } else {
                vc.dismissLoadingView()
            }
        })
    }
    
}
