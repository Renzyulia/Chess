//
//  Bishop.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class Bishop: Piece {
    let color: Color
    var isKing: Bool {
        return false
    }
    
    init(of color: Color) {
        self.color = color
    }
    
    // MARK: - Public methods
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        let possibleMovesDiagonallyUpAndLeft = move(rowOffset: 1, columnOffset: -1, context: context)
        let possibleMovesDiagonallyDownAndLeft = move(rowOffset: -1, columnOffset: -1, context: context)
        let possibleMovesDiagonallyUpAndRight = move(rowOffset: 1, columnOffset: 1, context: context)
        let possibleMovesDiagonallyDownAndRight = move(rowOffset: -1, columnOffset: 1, context: context)
        
        let possibleMoves = possibleMovesDiagonallyDownAndLeft + possibleMovesDiagonallyUpAndRight + possibleMovesDiagonallyUpAndLeft + possibleMovesDiagonallyDownAndRight
        
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
