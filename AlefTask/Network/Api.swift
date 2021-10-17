//
//  Api.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/21.
//

import Alamofire
import RxSwift


class Api {
    var disposeBag = DisposeBag()
    func fireRequestWithSingleResponse<T: Codable>(urlConvertible: Requestable, mappingClass: T.Type) -> Observable<T>{
        
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            if NetworkMonitor.shared.netOn {
                let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let value):
                        //Everything is fine, return the value in onNext
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        //Something went wrong, switch on the status code and return the error
                        print(error)
                        switch response.response?.statusCode {
                        case 404:
                            observer.onError(MyError.badAPIRequest)
                        case 500:
                            observer.onError(MyError.serverError)
                        case 502:
                            observer.onError(MyError.timeout)
                        default:
                            observer.onError(MyError.noInternet)
                        }
                    }
                }
            }else {
                observer.onError(MyError.noInternet)
            }
            
            
            //Finally, we return a disposable to stop the request
            return Disposables.create()
        }
    }
        
}
