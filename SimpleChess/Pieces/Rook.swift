//
//  Rook.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class Rook: Piece {
    let color: Color
    var isKing: Bool {
        return false
    }
    
    init(of color: Color) {
        self.color = color
    }
    // MARK: - Public methods
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        let possibleMovesDown = moves(rowOffset: -1, columnOffset: 0, context: context)
        let possibleMovesLeft = moves(rowOffset: 0, columnOffset: -1, context: context)
        let possibleMovesUp = moves(rowOffset: 1, columnOffset: 0, context: context)
        let possibleMovesRight = moves(rowOffset: 0, columnOffset: 1, context: context)
        let possibleMoves = possibleMovesDown + possibleMovesLeft + possibleMovesRight + possibleMovesUp
        
        return possibleMoves
    }
    
    func didMove() {
    }
    
    // MARK: - Private methods
    private func moves(rowOffset: Int, columnOffset: Int, context: GameContext) -> [RelativeCoordinate] {
        var possibleMoves: [RelativeCoordinate] = []
        var row = 0 + rowOffset
        var column = 0 + columnOffset
        
        while true {
            let tileCoordinate = RelativeCoordinate(row: row, column: column)
            let tile = context.tile(at: tileCoordinate)
            if !tile.isValid {
                break
            } else if !tile.isEmpty {
                if tile.isTakenByEnemy {
                    possibleMoves.append(tileCoordinate)
                    break
                } else {
                    break
                }
            } else {
                possibleMoves.append(tileCoordinate)
            }
            row += rowOffset
            column += columnOffset
        }
        return possibleMoves
    }
}
