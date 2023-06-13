//
//  Trampoline.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 23/04/23.
//

import SwiftUI

struct Trampoline: Tile, InteractProtocol {
    let color: Color = .black
    var position: Position
    let direction: Direction
    var playerId: UUID? = nil
    
    func ricochetFrom(_ key: KeyCode) -> KeyCode {
        switch self.direction {
        case .topLeft_bottomRight:
            switch key {
            case .arrowUp:
                return .arrowLeft
            case .arrowDown:
                return .arrowRight
            case .arrowLeft:
                return .arrowUp
            case .arrowRight:
                return .arrowDown
            }
        case .topRight_bottomLeft:
            switch key {
            case .arrowUp:
                return .arrowRight
            case .arrowDown:
                return .arrowLeft
            case .arrowLeft:
                return .arrowDown
            case .arrowRight:
                return .arrowUp
            }
        }
    }
    
    func onInteract(with key: KeyCode) -> [Position] {
        if playerId != nil {
            return interactAsWall(with: key)
        }
        return [self.position]
    }
}

extension Trampoline {
    static func == (lhs: Trampoline, rhs: Trampoline) -> Bool {
        lhs.position == rhs.position
    }
}
