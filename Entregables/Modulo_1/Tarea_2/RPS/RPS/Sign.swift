//
//  Sign.swift
//  RPS
//
//  Created by Álvaro Ávalos Hernández on 15/08/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import Foundation
import GameplayKit

//numero aleatorio
let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)

func randomSign() -> Sign {
    let sign = randomChoice.nextInt()
    if sign == 0 {
        return .rock
    } else if sign == 1 {
        return .paper
    } else {
        return .scissors
    }
}

enum Sign{
    case rock, paper, scissors
    //propiedades
    var emoji: String{
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "✋"
        case .scissors:
            return "✌️"
        }
    }
    
    func hand(_ otherHand: Sign) -> GameState {
        switch self {
        case .rock:
            switch otherHand{
            case .rock:
                return GameState.draw
            case .paper:
                return GameState.lose
            case .scissors:
                return GameState.win
            }
        case .paper:
            switch otherHand{
            case .rock:
                return GameState.win
            case .paper:
                return GameState.draw
            case .scissors:
                return GameState.lose
            }
        case .scissors:
            switch otherHand{
            case .rock:
                return GameState.lose
            case .paper:
                return GameState.win
            case .scissors:
                return GameState.draw
            }

        }
    }
}
