//
//  VisualElements.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

struct Pair {
  var piece: Piece
  var visualPiece: VisualPiece
}

struct VisualPiece {
    let image: UIImage
    let blackPieces = "Pieces/Black/"
    let whitePieces = "Pieces/White/"

    init(kingWithColor: Color) {
        switch kingWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "King")!
        case .black: image = UIImage(named: "\(blackPieces)" + "King")!
        }
    }
    
    init(queenWithColor: Color) {
        switch queenWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "Queen")!
        case .black: image = UIImage(named: "\(blackPieces)" + "Queen")!
        }
    }
    
    init(rookWithColor: Color) {
        switch rookWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "Rook")!
        case .black: image = UIImage(named: "\(blackPieces)" + "Rook")!
        }
    }
    
    init(knightWithColor: Color) {
        switch knightWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "Knight")!
        case .black: image = UIImage(named: "\(blackPieces)" + "Knight")!
        }
    }
    
    init(bishopWithColor: Color) {
        switch bishopWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "Bishop")!
        case .black: image = UIImage(named: "\(blackPieces)" + "Bishop")!
        }
    }
    
    init(pawnWithColor: Color) {
        switch pawnWithColor {
        case .white: image = UIImage(named: "\(whitePieces)" + "Pawn")!
        case .black: image = UIImage(named: "\(blackPieces)" + "Pawn")!
        }
    }
}

