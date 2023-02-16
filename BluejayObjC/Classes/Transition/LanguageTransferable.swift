//
//  LanguageTransferable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

protocol LanguageTransferable {
    
    associatedtype T
    
    func transfer() -> T
}
