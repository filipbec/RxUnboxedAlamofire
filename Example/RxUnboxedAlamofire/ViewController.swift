//
//  ViewController.swift
//  RxUnboxedAlamofire
//
//  Created by Filip Beć on 08/17/2017.
//  Copyright (c) 2017 Filip Beć. All rights reserved.
//

import UIKit
import Unbox
import RxSwift
import Alamofire
import RxAlamofire
import RxUnboxedAlamofire

class Person: Unboxable {
    let id: String
    let name: String
    let username: String
    let email: String

    required init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        username = try unboxer.unbox(key: "username")
        email = try unboxer.unbox(key: "email")
    }
}

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://jsonplaceholder.typicode.com/users/1"

        requestObject(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response: (HTTPURLResponse, Person)) in
                print(response)
            })
            .disposed(by: disposeBag)


        SessionManager.default.rx
            .object(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (person: Person) in
                print(person)
            })
            .disposed(by: disposeBag)


        SessionManager.default.rx
            .request(.get, url)
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .rx.object()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (person: Person) in
                print(person)
            })
            .disposed(by: disposeBag)
    }

}
