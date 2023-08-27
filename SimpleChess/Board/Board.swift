//
//  Board.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

protocol Board: AnyObject {
    var pieces: [Piece] { get }
    
    func kingPosition(for: Color) -> Coordinate
    func tile(at: Coordinate, for: Color) -> Tile
    func hasCheck(for: Color) -> Bool
    func board(afterMovingPieceFrom: Coordinate, to: Coordinate) -> Board
}
