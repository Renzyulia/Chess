//
//  Queen.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class Queen: Piece {
    let color: Color
    var isKing: Bool {
        return false
    }
    
    init(of color: Color) {
        self.color = color
    }
    
    // MARK: - Public methods
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        let possibleMovesDown = move(rowOffset: -1, columnOffset: 0, context: context)
        let possibleMovesLeft = move(rowOffset: 0, columnOffset: -1, context: context)
        let possibleMovesUp = move(rowOffset: 1, columnOffset: 0, context: context)
        let possibleMovesRight = move(rowOffset: 0, columnOffset: 1, context: context)
        let possibleMovesDiagonallyUpAndLeft = move(rowOffset: 1, columnOffset: -1, context: context)
        let possibleMovesDiagonallyDownAndLeft = move(rowOffset: -1, columnOffset: -1, context: context)
        let possibleMovesDiagonallyUpAndRight = move(rowOffset: 1, columnOffset: 1, context: context)
        let possibleMovesDiagonallyDownAndRight = move(rowOffset: -1, columnOffset: 1, context: context)
        
        let possibleMoves = possibleMovesDown + possibleMovesLeft + possibleMovesUp + possibleMovesRight + possibleMovesDiagonallyUpAndLeft + possibleMovesDiagonallyDownAndLeft + possibleMovesDiagonallyUpAndRight + possibleMovesDiagonallyDownAndRight
        
        return possibleMoves
    }
    
    func didMove() {
    }
    
    // MARK: - Private methods
    private func move(rowOffset: Int, columnOffset: Int, context: GameContext) -> [RelativeCoordinate] {
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
