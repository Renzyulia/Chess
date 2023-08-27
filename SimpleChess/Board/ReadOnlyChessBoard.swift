//
//  ChessBoardReadOnly.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class ReadOnlyChessBoard: Board {
    let storage: Storage
    var pieces: [Piece] {
        return storage.pieces
    }
    
    init(storage: Storage) {
        self.storage = storage
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
        let piece: Piece? = storage.piece(at: coordinate)
        
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
                let coordinate = self.storage.coordinate(of: piece)
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
    
    func board(afterMovingPieceFrom: Coordinate, to: Coordinate) -> Board {
        let movedPiece = storage.piece(at: afterMovingPieceFrom)
        let shadowStorage = storage.shadow(byMoving: movedPiece!, to: to)
        let board = ReadOnlyChessBoard(storage: shadowStorage)
        return board
    }
}
