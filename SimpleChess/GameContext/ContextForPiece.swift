//
//  ContextForPiece.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

class ContextForPiece: GameContext {
    let piece: Piece
    let coordinate: Coordinate
    let board: Board
    
    init(piece: Piece, coordinate: Coordinate, board: Board) {
        self.piece = piece
        self.coordinate = coordinate
        self.board = board
    }
    
    func tile(at: RelativeCoordinate) -> Tile {
        if let absoluteCoordinate = Coordinate(row: coordinate.row + at.row, column: coordinate.column + at.column) {
            return board.tile(at: absoluteCoordinate, for: piece.color)
        } else {
            return Tile(isValid: false, isEmpty: false, isTakenByEnemy: false)
        }
    }
    
    func board(afterMovingTo: RelativeCoordinate) -> GameContext {
        let absoluteCoordinate = Coordinate(row: coordinate.row + afterMovingTo.row, column: coordinate.column + afterMovingTo.column)!
        let shadowBoard = board.board(afterMovingPieceFrom: coordinate, to: absoluteCoordinate)
        return ContextForPiece(piece: piece, coordinate: absoluteCoordinate, board: shadowBoard)
    }
    
    func coordinate(moveForwardUpTo: Int, moveHorizontalTo: Int) -> RelativeCoordinate {
        if piece.color == .white {
            return RelativeCoordinate(row: moveForwardUpTo, column: moveHorizontalTo)
        } else {
            return RelativeCoordinate(row: -(moveForwardUpTo), column: moveHorizontalTo)
        }
    }
    
    func possibleMoves() -> [Coordinate] {
        var possibleMoves = [Coordinate]()
        for move in piece.possibleMoves(in: self) {
            let coordinate = Coordinate(row: coordinate.row + move.row, column: coordinate.column + move.column)
            possibleMoves.append(coordinate!)
        }
        return possibleMoves
    }
}
