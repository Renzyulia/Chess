//
//  ShadowStorageMovingPiece.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class ShadowStorageMovingPiece: Storage {
    var pieces: [Piece] {
        return originalStorage.pieces
    }
    var originalStorage: Storage
    var movedPiece: Piece
    var coordinate: Coordinate
    
    init(originalStorage: Storage, movedPiece: Piece, coordinate: Coordinate) {
        self.originalStorage = originalStorage
        self.movedPiece = movedPiece
        self.coordinate = coordinate
    }
    
    func piece(at coordinate: Coordinate) -> Piece? {
        let piece = originalStorage.piece(at: coordinate)
        if piece === movedPiece {
            return nil
        } else if coordinate == self.coordinate {
            return movedPiece
        } else {
            return piece
        }
    }
    
    func coordinate(of piece: Piece) -> Coordinate {
        if piece === movedPiece {
            return coordinate
        } else {
            return originalStorage.coordinate(of: piece)
        }
    }
}
