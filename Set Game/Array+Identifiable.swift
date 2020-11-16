//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by asfoury on 11/5/20.
//

import Foundation


extension Array where Element : Identifiable {
    func firstIndex(matching : Element) -> Int? { // Optional :  some( _ : Int) or none
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil 
    }
    
}

