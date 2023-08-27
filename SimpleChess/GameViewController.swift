//
//  ViewController.swift
//  SimpleChess
//
//  Created by Yulia Ignateva on 25.11.2021.
//

import UIKit

class GameViewController: UIViewController, GameControllerDelegate {
    var gameController: GameController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameController = GameController()
        self.gameController = gameController
        gameController.delegate = self
        
        let chessView = gameController.chessBoardView
        chessView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(chessView)
        
        NSLayoutConstraint.activate([
            chessView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
            chessView.heightAnchor.constraint(equalTo: view.widthAnchor),
            chessView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chessView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func gameOver(with status: StatusGame) {
        let label = UILabel()
        var text: String {
            switch status {
            case .WhiteWin: return "Game Over!" + "\n" + "White win"
            case .BlackWin: return "Game Over!" + "\n" + "Black win"
            case .Draw: return "Game Over!" + "\n" + "Draw"
            }
        }
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = label.font.withSize(35)
        label.backgroundColor = UIColor(named: "Backlight")
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
