//
//  StorageForPieces.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

class StorageForPieces: Storage, MutableStorage {
    
    struct BoardElement {
        let piece: Piece
        var coordinate: Coordinate
    }
    
    var pieces: [Piece] {
        var pieces = [Piece]()
        for element in boardElement {
            pieces.append(element.piece)
        }
        return pieces
    }
    
    var boardElement: [BoardElement] = []
    
    func piece(at coordinate: Coordinate) -> Piece? {
        var piece: Piece? = nil
        for element in boardElement {
            if element.coordinate == coordinate {
                piece = element.piece
                break
            }
        }
        return piece
    }
    
    func coordinate(of piece: Piece) -> Coordinate {
        var coordinate: Coordinate? = nil
        for element in boardElement {
            if element.piece === piece {
                coordinate = element.coordinate
                break
            }
        }
        return coordinate!
    }
    
    func remove(_ piece: Piece) {
        let index = searchIndex(in: boardElement, piece: piece)
        boardElement.remove(at: index)
    }
    
    func add(_ piece: Piece, at coordinate: Coordinate) {
        boardElement.append(BoardElement(piece: piece, coordinate: coordinate))
    }
    
    func move(_ piece: Piece, to coordinate: Coordinate) {
        let index = searchIndex(in: boardElement, piece: piece)
        boardElement[index].coordinate = coordinate
    }
    
    func searchIndex(in array: [BoardElement], piece: Piece) -> Int {
        var index = 0
        for i in 0..<array.count {
            if array[i].piece === piece {
                index = i
                break
            }
        }
        return index
    }
}
