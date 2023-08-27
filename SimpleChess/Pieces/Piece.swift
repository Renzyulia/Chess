//
//  ProtocolPiece.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

protocol Piece: AnyObject {
    var color: Color { get }
    var isKing: Bool { get }

    func possibleMoves(in: GameContext) -> [RelativeCoordinate]
    func didMove()
}
