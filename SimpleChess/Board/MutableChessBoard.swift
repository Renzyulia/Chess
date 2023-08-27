//
//  ChessBoardMutable.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class MutableChessBoard: Board {
    var storage: MutableStorage
    var pieces: [Piece] {
        return storage.pieces
    }
    var visualPieces: [Pair] = []
    
    init() {
        storage = StorageForPieces()
    }
    
    func kingPosition(for color: Color) -> Coordinate {
        var coordinate: Coordinate? = nil
        for piece in pieces {
            if piece.isKing && piece.color == color {
                coordinate = storage.coordinate(of: piece)
                break
            }
        }
        return coordinate!
    }
    
    func tile(at coordinate: Coordinate, for color: Color) -> Tile {
        let piece = storage.piece(at: coordinate)
        
        if piece == nil {
            return Tile.isEmpty
        } else if piece?.color != color {
            return Tile.withEnemy
        }
        return Tile.withAlly
    }
    
    func hasCheck(for color: Color) -> Bool {
        let kingPosition = kingPosition(for: color)
        
        for piece in pieces {
            if piece.color != color {
                let coordinate = storage.coordinate(of: piece)
                let context = ContextForPiece(piece: piece, coordinate: coordinate, board: self)
                for move in context.possibleMoves() {
                    if move == kingPosition {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func board(afterMovingPieceFrom: Coordinate, to coordinate: Coordinate) -> Board {
        let movedPiece = storage.piece(at: afterMovingPieceFrom)
        let shadowStorage = storage.shadow(byMoving: movedPiece!, to: coordinate)
        let board = ReadOnlyChessBoard(storage: shadowStorage)
        return board
    }
}
