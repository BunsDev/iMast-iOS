//
//  MastodonEndpointProtocol.swift
//
//  iMast https://github.com/cinderella-project/iMast
//
//  Created by user on 2020/03/09.
//
//  ------------------------------------------------------------------------
//
//  Copyright 2017-2019 rinsuki and other contributors.
// 
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Foundation

public protocol MastodonEndpointProtocol {
    associatedtype Response: MastodonEndpointResponse
    
    /// e.g. "/api/v1/account"
    var endpoint: String { get }
    var method: String { get }

    var query: [URLQueryItem] { get }
    var body: Data? { get }
}

extension MastodonEndpointProtocol {
    public var query: [URLQueryItem] { return [] }
    public var body: Data? { return nil }
}

public protocol MastodonEndpointResponse {
    static func decode(data: Data, httpHeaders: [String: String]) throws -> Self
}

extension MastodonEndpointResponse where Self: Decodable {
    public static func decode(data: Data, httpHeaders: [String: String]) throws -> Self {
        let decoder = JSONDecoder.forMastodonAPI
        return try decoder.decode(Self.self, from: data)
    }
}

extension Array: MastodonEndpointResponse where Element: Decodable {
}
