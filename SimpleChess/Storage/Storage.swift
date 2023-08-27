//
//  Storage.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

protocol Storage: AnyObject {
    var pieces: [Piece] { get }
    
    func piece(at: Coordinate) -> Piece?
    func coordinate(of: Piece) -> Coordinate
    
    func shadow(byRemoving: Piece) -> Storage
    func shadow(byAdding: Piece, at: Coordinate) -> Storage
    func shadow(byMoving: Piece, to: Coordinate) -> Storage
}

extension Storage {
    func shadow(byRemoving: Piece) -> Storage {
        let shadowStorage = ShadowStorageRemovingPiece(originalStorage: self, removedPiece: byRemoving)
        return shadowStorage
    }
    
    func shadow(byAdding: Piece, at: Coordinate) -> Storage {
        let shadowStorage = ShadowStorageAddingPiece(originalStorage: self, addedPiece: byAdding, coordinate: at)
        return shadowStorage
    }
    
    func shadow(byMoving: Piece, to: Coordinate) -> Storage {
        let enemyPiece: Piece? = piece(at: to)
        if let enemyPiece = enemyPiece {
            let shadowStorage = ShadowStorageRemovingPiece(originalStorage: self, removedPiece: enemyPiece)
            return shadowStorage.shadow(byMoving: byMoving, to: to)
        } else {
            let shadowStorage = ShadowStorageMovingPiece(originalStorage: self, movedPiece: byMoving, coordinate: to)
            return shadowStorage
        }
    }
}
