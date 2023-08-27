//
//  ShadowStorageRemovingPiece.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class ShadowStorageRemovingPiece: Storage {
    var pieces: [Piece] {
        var pieces = originalStorage.pieces
        for index in 0..<pieces.count {
            if pieces[index] === removedPiece {
                pieces.remove(at: index)
                break
            }
        }
        return pieces
    }
    let originalStorage: Storage
    let removedPiece: Piece
    
    init(originalStorage: Storage, removedPiece: Piece) {
        self.originalStorage = originalStorage
        self.removedPiece = removedPiece
    }
    
    func piece(at coordinate: Coordinate) -> Piece? {
        let piece = originalStorage.piece(at: coordinate)
        if piece === removedPiece {
            return nil
        } else {
            return piece
        }
    }
    
    func coordinate(of piece: Piece) -> Coordinate {
        if piece === removedPiece {
            fatalError("The piece doesn't exist")
        } else {
            return originalStorage.coordinate(of: piece)
        }
    }
}
