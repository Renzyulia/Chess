//
//  King.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class King: Piece {
    let color: Color
    var isKing: Bool {
        return true
    }
    
    init(of color: Color) {
        self.color = color
    }
    
    // MARK: - Public methods
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        var possibleMoves = [RelativeCoordinate]()
        
        let relativePositions = [RelativeCoordinate(row: 1, column: 0), //moveUp
                                 RelativeCoordinate(row: 1, column: 1), //moveDiagonallyUpAndRight
                                 RelativeCoordinate(row: 0, column: 1), //moveRight
                                 RelativeCoordinate(row: -1, column: 1), //moveDiagonallyDownAndRight
                                 RelativeCoordinate(row: -1, column: 0), //moveDown
                                 RelativeCoordinate(row: -1, column: -1), //moveDiagonallyDownAndLeft
                                 RelativeCoordinate(row: 0, column: -1), //moveLeft
                                 RelativeCoordinate(row: 1, column: -1)] //moveDiagonallyUpAndLeft
        
        for coordinate in relativePositions {
            if move(to: coordinate, context: context) {
                possibleMoves.append(coordinate)
            }
        }
        
        return possibleMoves
    }
    
    func didMove() {
    }
    
    // MARK: - Private methods
    private func move(to coordinate: RelativeCoordinate, context: GameContext) -> Bool {
        let tile = context.tile(at: coordinate)
        if tile.isEmpty || tile.isTakenByEnemy {
            return true
        } else {
            return false
        }
    }
}
