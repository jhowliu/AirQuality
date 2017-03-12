//
//  ArrayHelper.swift
//  AQI
//
//  Created by jhow on 12/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

extension Array {
    func checkIfExist(node: Node) -> Int? {
        var counter = 0
        
        for obj in self {
            let tmp = obj as! Node
            if tmp.district == node.district { return counter }
            counter += 1
        }
        
        return nil
    }
}
