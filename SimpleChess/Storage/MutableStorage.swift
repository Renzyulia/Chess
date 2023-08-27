//
//  MutableStorage.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 02.03.2022.
//

import UIKit

protocol MutableStorage: Storage {
    func remove(_: Piece)
    func add(_: Piece, at: Coordinate)
    func move(_: Piece, to: Coordinate)
}
