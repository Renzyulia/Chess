//
//  GameContext.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

protocol GameContext {
    func tile(at: RelativeCoordinate) -> Tile
    func board(afterMovingTo: RelativeCoordinate) -> GameContext
    func possibleMoves() -> [Coordinate]
    func coordinate(moveForwardUpTo: Int, moveHorizontalTo: Int) -> RelativeCoordinate
}
