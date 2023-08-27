//
//  GameController.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 08.02.2022.
//

import UIKit

class GameController: ChessBoardViewDelegate {
    weak var delegate: GameControllerDelegate?
    var chessBoardView = ChessBoardView()
    
    private var board = MutableChessBoard()
    private var currentPlayerColor: Color = .white
    private var selectedPiece: Piece? = nil
    private var positionOfSelectedPiece: Coordinate? = nil
    private var possibleMoves = [Coordinate]()
    
    init() {
        chessBoardView.delegate = self
        
        create(Rook(of: .white), at: Coordinate(row: 0, column: 0)!, with: VisualPiece(rookWithColor: .white))
        create(Knight(of: .white), at: Coordinate(row: 0, column: 1)!, with: VisualPiece(knightWithColor: .white))
        create(Bishop(of: .white), at: Coordinate(row: 0, column: 2)!, with: VisualPiece(bishopWithColor: .white))
        create(Queen(of: .white), at: Coordinate(row: 0, column: 3)!, with: VisualPiece(queenWithColor: .white))
        create(King(of: .white), at: Coordinate(row: 0, column: 4)!, with: VisualPiece(kingWithColor: .white))
        create(Bishop(of: .white), at: Coordinate(row: 0, column: 5)!, with: VisualPiece(bishopWithColor: .white))
        create(Knight(of: .white), at: Coordinate(row: 0, column: 6)!, with: VisualPiece(knightWithColor: .white))
        create(Rook(of: .white), at: Coordinate(row: 0, column: 7)!, with: VisualPiece(rookWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 0)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 1)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 2)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 3)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 4)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 5)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 6)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .white), at: Coordinate(row: 1, column: 7)!, with: VisualPiece(pawnWithColor: .white))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 0)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 1)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 2)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 3)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 4)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 5)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 6)!, with: VisualPiece(pawnWithColor: .black))
        create(Pawn(of: .black), at: Coordinate(row: 6, column: 7)!, with: VisualPiece(pawnWithColor: .black))
        create(Rook(of: .black), at: Coordinate(row: 7, column: 0)!, with: VisualPiece(rookWithColor: .black))
        create(Knight(of: .black), at: Coordinate(row: 7, column: 1)!, with: VisualPiece(knightWithColor: .black))
        create(Bishop(of: .black), at: Coordinate(row: 7, column: 2)!, with: VisualPiece(bishopWithColor: .black))
        create(Queen(of: .black), at: Coordinate(row: 7, column: 3)!, with: VisualPiece(queenWithColor: .black))
        create(King(of: .black), at: Coordinate(row: 7, column: 4)!, with: VisualPiece(kingWithColor: .black))
        create(Bishop(of: .black), at: Coordinate(row: 7, column: 5)!, with: VisualPiece(bishopWithColor: .black))
        create(Knight(of: .black), at: Coordinate(row: 7, column: 6)!, with: VisualPiece(knightWithColor: .black))
        create(Rook(of: .black), at: Coordinate(row: 7, column: 7)!, with: VisualPiece(rookWithColor: .black))
    }
    
    func create(_ piece: Piece, at coordinate: Coordinate, with visualPiece: VisualPiece) {
        board.storage.add(piece, at: coordinate)
        board.visualPieces.append(Pair(piece: piece, visualPiece: visualPiece))
        chessBoardView.setPiece(at: coordinate, with: visualPiece.image)
    }
    
    func userDidTap(on coordinate: Coordinate) {
        if let selectedPiece = selectedPiece {
            secondTap(on: coordinate, selectedPiece: selectedPiece)
            
            possibleMoves.removeAll() //очищаем наш массив возможных ходов
            self.selectedPiece = nil //обнуляем выбранную фигуру
            positionOfSelectedPiece = nil //обнуляем координату выбранной фигуры
        } else {
            firstTap(on: coordinate)
        }
    }
    
    private func firstTap(on coordinate: Coordinate) {
        if let piece = board.storage.piece(at: coordinate) {
            if currentPlayerColor == piece.color {
                selectedPiece = piece
                positionOfSelectedPiece = coordinate
            }
            
            guard selectedPiece != nil else { return }
            let context = ContextForPiece(piece: selectedPiece!, coordinate: coordinate, board: board)
            for move in context.possibleMoves() {
                let shadowBoard = board.board(afterMovingPieceFrom: coordinate, to: move)
                if shadowBoard.hasCheck(for: piece.color) == false {
                    possibleMoves.append(move)
                }
            }
            
            if possibleMoves.isEmpty {
                selectedPiece = nil
                positionOfSelectedPiece = nil
            }
            
            for coordinate in possibleMoves {
                chessBoardView.glowChange(by: coordinate, turnOn: true)
            }
        }
    }
    
    private func secondTap(on coordinate: Coordinate, selectedPiece: Piece) {
        for coordinate in possibleMoves {
            chessBoardView.glowChange(by: coordinate, turnOn: false)
        }
        
        for move in possibleMoves {
            if move == coordinate {  // здесь мы проверяем, что в нашем массиве, который мы сделали на первом тапе (исключили шаги, которые ведут к шаху), есть клетка, на которую мы нажали
                let tile = board.tile(at: move, for: selectedPiece.color) // если есть, то мы выявляем какой у нее тип
                
                var visualPiece: VisualPiece! = nil // здесь мы сразу находим нашу картинку для выбранной фигуры
                for pair in board.visualPieces {
                    if pair.piece === selectedPiece {
                        visualPiece = pair.visualPiece
                        break
                    }
                }
                
                if tile.isTakenByEnemy { // если клетка занята врагом, то
                    chessBoardView.removePiece(at: move) // мы удаляем на доске эту вражескую фигуру
                    chessBoardView.removePiece(at: positionOfSelectedPiece!) //удаляем нашу фигуру с прошлого места
                    chessBoardView.movePiece(visualPiece: visualPiece, to: move) //вставляем ее на новое место
                    
                    let enemyPiece = board.storage.piece(at: coordinate)
                    board.storage.remove(enemyPiece!) // удаляем фигуру из board
                    board.storage.move(selectedPiece, to: coordinate) // передвигаем фигуру внутри board
                    selectedPiece.didMove()
                    
                    if currentPlayerColor == .white {
                        currentPlayerColor = .black
                    } else {
                        currentPlayerColor = .white
                    }
                } else if tile.isEmpty {
                    chessBoardView.removePiece(at: positionOfSelectedPiece!)
                    chessBoardView.movePiece(visualPiece: visualPiece, to: move)
                    board.storage.move(selectedPiece, to: coordinate)
                    selectedPiece.didMove()
                    
                    if currentPlayerColor == .white {
                        currentPlayerColor = .black
                    } else {
                        currentPlayerColor = .white
                    }
                }
                break
            }
        }
        
        var colorEnemy = Color.black
        if selectedPiece.color == .black {
            colorEnemy = .white
        } else {
            colorEnemy = .black
        }
        
        if board.hasCheck(for: colorEnemy) {
            if moveIsPossible(for: colorEnemy) == false {
                if colorEnemy == .white {
                    delegate?.gameOver(with: .BlackWin)
                } else {
                    delegate?.gameOver(with: .WhiteWin)
                }
            }
        } else {
            if moveIsPossible(for: colorEnemy) == false {
                delegate?.gameOver(with: .Draw)
            }
        }
        if board.pieces.count == 2 {
            for piece in board.pieces {
                if piece.isKing {
                    delegate?.gameOver(with: .Draw)
                    break
                }
            }
        }
    }
    
    private func moveIsPossible(for color: Color) -> Bool {
        for piece in board.storage.pieces {
            if piece.color == color {
                let coordinate = board.storage.coordinate(of: piece)
                let context = ContextForPiece(piece: piece, coordinate: coordinate, board: board)
                for move in context.possibleMoves() {
                    if board.board(afterMovingPieceFrom: coordinate, to: move).hasCheck(for: color) == false {
                        return true
                    }
                }
            }
        }
        return false
    }
}

protocol GameControllerDelegate: AnyObject {
    func gameOver(with: StatusGame)
}

enum StatusGame {
    case WhiteWin
    case BlackWin
    case Draw
}
