//
//  Knight.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class Knight: Piece {
    let color: Color
    var isKing: Bool {
        return false
    }
    
    init(of color: Color) {
        self.color = color
    }
 
    // MARK: - Public methods
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        let relativeCoordinates = [RelativeCoordinate(row: 1, column: 2), // moveRightAndUp
                                 RelativeCoordinate(row: -1, column: 2), //moveRightAndDown
                                 RelativeCoordinate(row: -2, column: 1), //moveDownAndRight
                                 RelativeCoordinate(row: -2, column: -1), //moveDownAndLeft
                                 RelativeCoordinate(row: -1, column: -2), //moveLeftAndDown
                                 RelativeCoordinate(row: 1, column: -2), //moveLeftAndUp
                                 RelativeCoordinate(row: 2, column: -1), //moveUpAndLeft
                                 RelativeCoordinate(row: 2, column: 1)] //moveUpAndRight
        
        var possibleMoves = [RelativeCoordinate]()
        
        for coordinate in relativeCoordinates {
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
