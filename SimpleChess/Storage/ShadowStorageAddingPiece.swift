//
//  ShadowStorageAdditingPiece.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class ShadowStorageAddingPiece: Storage {
    var pieces: [Piece] {
        var pieces = originalStorage.pieces
        pieces.append(addedPiece)
        return pieces
    }
    var originalStorage: Storage
    var addedPiece: Piece
    var coordinate: Coordinate
    
    init(originalStorage: Storage, addedPiece: Piece, coordinate: Coordinate) {
        self.originalStorage = originalStorage
        self.addedPiece = addedPiece
        self.coordinate = coordinate
    }
    
    func piece(at coordinate: Coordinate) -> Piece? {
        let piece = originalStorage.piece(at: coordinate)
        if coordinate == self.coordinate {
            return addedPiece
        } else {
            return piece
        }
    }
    
    func coordinate(of piece: Piece) -> Coordinate {
        if piece === addedPiece {
            return coordinate
        } else {
            return originalStorage.coordinate(of: piece)
        }
    }
}
