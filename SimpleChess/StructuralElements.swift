//
//  StructuralElements.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

enum Color {
    case white
    case black
}

struct Coordinate: Equatable {
    var row: Int
    var column: Int
    
    init?(row: Int, column: Int) {
        guard row >= 0 && row < 8 else { return nil }
        guard column >= 0 && column < 8 else { return nil }
        
        self.row = row
        self.column = column
    }
}

struct RelativeCoordinate {
    var row: Int
    var column: Int
}

struct Tile: Equatable {
    var isValid: Bool
    var isEmpty: Bool
    var isTakenByEnemy: Bool
    
    static var invalid: Tile {
        return Tile(isValid: false, isEmpty: false, isTakenByEnemy: false)
    }
    
    static var isEmpty: Tile {
        return Tile(isValid: true, isEmpty: true, isTakenByEnemy: false)
    }
    
    static var withEnemy: Tile {
        return Tile(isValid: true, isEmpty: false, isTakenByEnemy: true)
    }
    
    static var withAlly: Tile {
        return Tile(isValid: true, isEmpty: false, isTakenByEnemy: false)
    }
}
