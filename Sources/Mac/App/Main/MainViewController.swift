//
//  MainViewController.swift
//
//  iMast https://github.com/cinderella-project/iMast
//
//  Created by user on 2019/11/10.
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

import Cocoa
import iMastMacCore

class MainViewController: NSViewController, MaybeHasUserToken {
    @objc dynamic var child: NSViewController? = nil {
        didSet {
            if let vc = oldValue {
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
            if let vc = child {
                addChild(vc)
                view.addSubview(vc.view)
                vc.view.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                vc.view.becomeFirstResponder()
            }
        }
    }
    
    override func loadView() {
        view = .init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let userToken = MastodonUserToken.getLatestUsed() {
            child = TimelineViewController(userToken: userToken, timelineType: .home)
        }
        bind(.title, to: self, withKeyPath: "child.title", options: nil)
    }

    func getUserTokenIfAvailable() -> MastodonUserToken? {
        return (child as? MaybeHasUserToken)?.getUserTokenIfAvailable()
    }
}
