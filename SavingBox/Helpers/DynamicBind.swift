//
//  DynamicBind.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 17/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

 class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}
