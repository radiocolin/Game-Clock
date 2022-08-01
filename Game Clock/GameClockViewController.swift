//
//  ViewController.swift
//  Game Clock
//
//  Created by Colin Weir on 5/20/22.
//

import UIKit

class GameClockViewController: UIViewController {
    
    var game = Game()

    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player1Stop: UIButton!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player2Stop: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var player1View: UIView!
    @IBOutlet weak var player2View: UIView!

    var timer = Timer()
    
    @objc func updateLabels() {
        if game.player1.clock.timeRemaining > 0 {
            player1Label.text = game.player1.clock.timeRemainingText
        } else if game.player1.clock.timeRemaining < 1 {
            player1Label.text = "TIME'S UP!"
            player1Label.textColor = .white
            player1Label.backgroundColor = .systemRed
        }
        if game.player2.clock.timeRemaining > 0 {
            player2Label.text = game.player2.clock.timeRemainingText
        } else if game.player2.clock.timeRemaining < 1 {
            player2Label.text = "TIME'S UP!"
            player2Label.textColor = .white
            player2Label.backgroundColor = .systemRed
        }
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        game.startGame()
        player1View.backgroundColor = .systemGray5
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: (#selector(updateLabels)), userInfo: nil, repeats: true)
        player1Stop.isEnabled = true
        startButton.isEnabled = false
        settingsButton.isEnabled = false
        resetButton.isEnabled = true
        pauseButton.isEnabled = true
    }
    
    @IBAction func stopAndSwitch(_ sender: UIButton) {
        game.switchTurn()
        if game.player1.active {
            player1Stop.isEnabled = true
            player2Stop.isEnabled = false
        } else if game.player2.active {
            player1Stop.isEnabled = false
            player2Stop.isEnabled = true
        }
        if game.player1.active {
            player1View.backgroundColor = .systemGray5
        } else {
            player1View.backgroundColor = .clear
        }
        
        if game.player2.active {
            player2View.backgroundColor = .systemGray5
        } else {
            player2View.backgroundColor = .clear
        }
    }
    
    @IBAction func pauseGame(_ sender: UIButton) {
        if game.gameState == .active {
            game.pauseGame()
            player1Stop.isEnabled = false
            player2Stop.isEnabled = false
            pauseButton.setTitle("Resume", for: .normal)
        } else if game.gameState == .paused {
            game.resumeGame()
            if game.player1.active {
                player1Stop.isEnabled = true
            } else if game.player2.active {
                player2Stop.isEnabled = true
            }
            pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        game.stopGame()
        timer.invalidate()
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        player1Stop.isEnabled = false
        player2Stop.isEnabled = false
        startButton.isEnabled = true
        settingsButton.isEnabled = true
        player1Label.text = game.player1.clock.timeRemainingText
        player2Label.text = game.player2.clock.timeRemainingText
        player1Label.backgroundColor = .clear
        player2Label.backgroundColor = .clear
        player1Label.textColor = .black
        player2Label.textColor = .black
        player1View.backgroundColor = .clear
        player2View.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        player1Label.text = game.player1.clock.timeRemainingText
        player2Label.text = game.player2.clock.timeRemainingText
        player1View.transform = CGAffineTransform(rotationAngle: .pi)
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        player1Stop.isEnabled = false
        player2Stop.isEnabled = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SettingsViewController {
            let settingsController = segue.destination as? SettingsViewController
            settingsController?.game = game
        }
    }

    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        if segue.identifier == "saveSettings" {
            game.player1.clock.setTimeRemaining(game.timeSetting)
            game.player2.clock.setTimeRemaining(game.timeSetting)
            player1Label.text = game.player1.clock.timeRemainingText
            player2Label.text = game.player2.clock.timeRemainingText
        }
    }
    
}

