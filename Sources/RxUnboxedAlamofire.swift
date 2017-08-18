//
//  RxUnboxedAlamofire.swift
//  Pods
//
//  Created by Filip Bec on 17/08/2017.
//
//

import Unbox
import RxSwift
import Alamofire
import RxAlamofire
import UnboxedAlamofire

public func requestObject<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                           _ url: URLConvertible,
                           parameters: [String: Any]? = nil,
                           encoding: ParameterEncoding = URLEncoding.default,
                           headers: [String: String]? = nil,
                           options: JSONSerialization.ReadingOptions = .allowFragments,
                           keyPath: String? = nil
    )
    -> Observable<(HTTPURLResponse, T)>
{
    return SessionManager.default.rx.responseObject(
        method,
        url,
        parameters: parameters,
        encoding: encoding,
        headers: headers,
        options: options,
        keyPath: keyPath
    )
}

public func requestObject<T: Unboxable>(_ urlRequest: URLRequestConvertible,
                          options: JSONSerialization.ReadingOptions = .allowFragments,
                          keyPath: String? = nil
    )
    -> Observable<(HTTPURLResponse, T)>
{
    return request(urlRequest).flatMap { $0.rx.responseObject(options: options, keyPath: keyPath) }
}

public func object<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                   _ url: URLConvertible,
                   parameters: [String: Any]? = nil,
                   encoding: ParameterEncoding = URLEncoding.default,
                   headers: [String: String]? = nil,
                   options: JSONSerialization.ReadingOptions = .allowFragments,
                   keyPath: String? = nil
    )
    -> Observable<T>
{
    return SessionManager.default.rx.object(
        method,
        url,
        parameters: parameters,
        encoding: encoding,
        headers: headers,
        options: options,
        keyPath: keyPath
    )
}

public func requestArray<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                          _ url: URLConvertible,
                          parameters: [String: Any]? = nil,
                          encoding: ParameterEncoding = URLEncoding.default,
                          headers: [String: String]? = nil,
                          options: JSONSerialization.ReadingOptions = .allowFragments,
                          keyPath: String? = nil
    )
    -> Observable<(HTTPURLResponse, [T])>
{
    return SessionManager.default.rx.responseArray(
        method,
        url,
        parameters: parameters,
        encoding: encoding,
        headers: headers,
        options: options,
        keyPath: keyPath
    )
}

public func requestArray<T: Unboxable>(_ urlRequest: URLRequestConvertible,
                          options: JSONSerialization.ReadingOptions = .allowFragments,
                          keyPath: String? = nil
    )
    -> Observable<(HTTPURLResponse, [T])>
{
    return request(urlRequest).flatMap { $0.rx.responseArray(options: options, keyPath: keyPath) }
}

public func array<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                  _ url: URLConvertible,
                  parameters: [String: Any]? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: [String: String]? = nil,
                  options: JSONSerialization.ReadingOptions = .allowFragments,
                  keyPath: String? = nil
    )
    -> Observable<[T]>
{
    return SessionManager.default.rx.array(
        method,
        url,
        parameters: parameters,
        encoding: encoding,
        headers: headers,
        options: options,
        keyPath: keyPath
    )
}

extension Reactive where Base: SessionManager {

    public func responseObject<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                               _ url: URLConvertible,
                               parameters: [String: Any]? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: [String: String]? = nil,
                               options: JSONSerialization.ReadingOptions = .allowFragments,
                               keyPath: String? = nil
        )
        -> Observable<(HTTPURLResponse, T)>
    {
        return request(method,
                       url,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers
            ).flatMap { $0.rx.responseObject(options: options, keyPath: keyPath) }
    }

    public func object<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                       _ url: URLConvertible,
                       parameters: [String: Any]? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: [String: String]? = nil,
                       options: JSONSerialization.ReadingOptions = .allowFragments,
                       keyPath: String? = nil
        )
        -> Observable<T>
    {
        return request(method,
                       url,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers
            ).flatMap { $0.rx.object(options: options, keyPath: keyPath) }
    }

    public func responseArray<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                               _ url: URLConvertible,
                               parameters: [String: Any]? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: [String: String]? = nil,
                               options: JSONSerialization.ReadingOptions = .allowFragments,
                               keyPath: String? = nil
        )
        -> Observable<(HTTPURLResponse, [T])>
    {
        return request(method,
                       url,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers
            ).flatMap { $0.rx.responseArray(options: options, keyPath: keyPath) }
    }

    public func array<T: Unboxable>(_ method: Alamofire.HTTPMethod,
                       _ url: URLConvertible,
                       parameters: [String: Any]? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: [String: String]? = nil,
                       options: JSONSerialization.ReadingOptions = .allowFragments,
                       keyPath: String? = nil
        )
        -> Observable<[T]>
    {
        return request(method,
                       url,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers
            ).flatMap { $0.rx.array(options: options, keyPath: keyPath) }
    }

}

extension Reactive where Base: DataRequest {

    // MARK: - Object -

    public func responseObject<T: Unboxable>(options: JSONSerialization.ReadingOptions = .allowFragments, keyPath: String? = nil) -> Observable<(HTTPURLResponse, T)> {
        return responseResult(responseSerializer: Base.unboxObjectResponseSerializer(options: options, keyPath: keyPath))
    }

    public func object<T: Unboxable>(options: JSONSerialization.ReadingOptions = .allowFragments, keyPath: String? = nil) -> Observable<T> {
        return result(responseSerializer: Base.unboxObjectResponseSerializer(options: options, keyPath: keyPath))
    }

    // MARK: - Array -

    public func responseArray<T: Unboxable>(options: JSONSerialization.ReadingOptions = .allowFragments, keyPath: String? = nil) -> Observable<(HTTPURLResponse, [T])> {
        return responseResult(responseSerializer: Base.unboxArrayResponseSerializer(options: options, keyPath: keyPath))
    }

    public func array<T: Unboxable>(options: JSONSerialization.ReadingOptions = .allowFragments, keyPath: String? = nil) -> Observable<[T]> {
        return result(responseSerializer: Base.unboxArrayResponseSerializer(options: options, keyPath: keyPath))
    }
}
