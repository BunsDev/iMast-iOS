//
//  MastodonSearchResult.swift
//  iMast
//
//  Created by user on 2018/01/10.
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
//

import Foundation
import Hydra

class MastodonSearchResult: Codable {
    let accounts: [MastodonAccount]
    let posts: [MastodonPost]
    let hashtags: [String]
    enum CodingKeys: String, CodingKey {
        case accounts
        case posts = "statuses"
        case hashtags
    }
}

extension MastodonUserToken {
    func search(q: String, resolve: Bool = true) -> Promise<MastodonSearchResult> { 
        return self.get("search", params: ["q": q, "resolve": resolve]).then { res -> MastodonSearchResult in
            return try MastodonSearchResult.decode(json: res)
        }
    }
}
