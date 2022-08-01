//
//  GameClock.swift
//  Game Clock
//
//  Created by Colin Weir on 6/16/22.
//

import Foundation
import UIKit

class Game {
    enum gameState {
        case active
        case paused
        case inactive
    }
    
    var gameState: gameState = .inactive
    var timeSetting = 30
    var player1 = Player()
    var player2 = Player()
    
    func startGame() {
        self.gameState = .active
        player1.startTurn()
    }
    
    func pauseGame() {
        self.gameState = .paused
        
        if player1.active {
            player1.pauseTurn()
        }
        
        if player2.active {
            player2.pauseTurn()
        }
    }
    
    func resumeGame() {
        self.gameState = .active
        
        if player1.active {
            player1.startTurn()
        } else if player2.active {
            player2.startTurn()
        }
    }
    
    func stopGame() {
        self.gameState = .inactive
        player1.stopTurn()
        player2.stopTurn()
        player1.clock.setTimeRemaining(timeSetting)
        player2.clock.setTimeRemaining(timeSetting)
    }
    
    func switchTurn() {
        if player1.active {
            player1.stopTurn()
            player2.startTurn()
        }
        
        else if player2.active {
            player2.stopTurn()
            player1.startTurn()
        }
        
    }
    
}

class Player {
    var active = false
    var timer = Timer()
    var clock = Clock()

    func startTurn() {
        self.active = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.clock.tick()
        }
    }
    
    func stopTurn() {
        self.active = false
        self.timer.invalidate()
    }
    
    func pauseTurn() {
        self.timer.invalidate()
    }
}

struct Clock {
    var timeRemaining = 30
    var timeRemainingText: String {
        let minutes = String(timeRemaining / 60)
        let seconds = String(format: "%02d", timeRemaining % 60)
        return minutes + ":" + seconds
    }
    
    mutating func tick() {
        timeRemaining -= 1
    }
    
    mutating func setTimeRemaining(_ seconds: Int) {
        self.timeRemaining = seconds
    }
}


