//
//  Observerable.swift
//  NoStoryboard
//
//  Created by Minh on 16/9/25.
//

import Foundation

class Observerable<T>{
    var value:T {
        didSet{
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value:T){
        self.value = value
    }
    
    func bind(listener:@escaping (T) -> Void ){
        self.listener = listener
        listener(value)
    }
}
