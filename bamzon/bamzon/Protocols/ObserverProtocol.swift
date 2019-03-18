//
//  ObserverProtocol.swift
//  bamzon
//
//  Created by liblabs-mac on 3/17/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

protocol Observer {
    func update()
}

protocol Observable {
    func addObserver(obs: Observer)
    func removeObservers()
    func notifyObservers()
}
