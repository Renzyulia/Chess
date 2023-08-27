//
//  Pawn.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

final class Pawn: Piece {
    private var firstMove = true
    let color: Color
    var isKing: Bool {
        return false
    }
    
    init(of color: Color) {
        self.color = color
    }
    
    func possibleMoves(in context: GameContext) -> [RelativeCoordinate] {
        var possibleMoves = [RelativeCoordinate]()
        let oneTileUp = context.coordinate(moveForwardUpTo: 1, moveHorizontalTo: 0)
        let twoTilesUp = context.coordinate(moveForwardUpTo: 2, moveHorizontalTo: 0)
        let tileDiagonallyRight = context.coordinate(moveForwardUpTo: 1, moveHorizontalTo: 1)
        let tileDiagonallyLeft = context.coordinate(moveForwardUpTo: 1, moveHorizontalTo: -1)
        
        switch firstMove {
        case true:
            if context.tile(at: twoTilesUp).isEmpty && context.tile(at: oneTileUp).isEmpty {
                possibleMoves.append(twoTilesUp)
            }
            if context.tile(at: oneTileUp).isEmpty {
                possibleMoves.append(oneTileUp)
            }
            if context.tile(at: tileDiagonallyRight).isTakenByEnemy {
                possibleMoves.append(tileDiagonallyRight)
            }
            if context.tile(at: tileDiagonallyLeft).isTakenByEnemy {
                possibleMoves.append(tileDiagonallyLeft)
            }
            
        case false:
            if context.tile(at: oneTileUp).isEmpty {
                possibleMoves.append(oneTileUp)
            }
            if context.tile(at: tileDiagonallyRight).isTakenByEnemy {
                possibleMoves.append(tileDiagonallyRight)
            }
            if context.tile(at: tileDiagonallyLeft).isTakenByEnemy {
                possibleMoves.append(tileDiagonallyLeft)
            }
        }
        return possibleMoves
    }
    
    func didMove() {
        firstMove = false
    }
}
