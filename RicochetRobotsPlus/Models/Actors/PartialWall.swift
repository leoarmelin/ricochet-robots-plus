//
//  PartialWall.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct PartialWall: Tile, InteractProtocol {
    let color: Color = .black
    var position: Position
    let sidesBlock: [Side]
    var playerId: UUID? = nil
    
    func onInteract(with key: KeyCode) -> [Position] {
        if playerId != nil {
            return interactAsWall(with: key)
        }
        
        switch key {
        case .arrowUp:
            if sidesBlock.contains(.bottom) {
                return [Position(x: self.position.x, y: self.position.y + 1)]
            }
            return [Position(x: self.position.x, y: self.position.y)]
        case .arrowDown:
            if sidesBlock.contains(.top) {
                return [Position(x: self.position.x, y: self.position.y - 1)]
            }
            return [Position(x: self.position.x, y: self.position.y)]
        case .arrowLeft:
            if sidesBlock.contains(.right) {
                return [Position(x: self.position.x + 1, y: self.position.y)]
            }
            return [Position(x: self.position.x, y: self.position.y)]
        case .arrowRight:
            if sidesBlock.contains(.left) {
                return [Position(x: self.position.x - 1, y: self.position.y)]
            }
            return [Position(x: self.position.x, y: self.position.y)]
        }
    }
    
    func isBlockingMovement(for key: KeyCode, _ position: Position) -> Bool {
        switch key {
        case .arrowUp:
            if self.position.y == position.y {
                return sidesBlock.contains(.top)
            }
            return sidesBlock.contains(.top) || sidesBlock.contains(.bottom)
        case .arrowDown:
            if self.position.y == position.y {
                return sidesBlock.contains(.bottom)
            }
            return sidesBlock.contains(.top) || sidesBlock.contains(.bottom)
        case .arrowLeft:
            if self.position.x == position.x {
                return sidesBlock.contains(.left)
            }
            return sidesBlock.contains(.left) || sidesBlock.contains(.right)
        case .arrowRight:
            if self.position.x == position.x {
                return sidesBlock.contains(.right)
            }
            return sidesBlock.contains(.left) || sidesBlock.contains(.right)
        }
    }
}

extension PartialWall {
    static func == (lhs: PartialWall, rhs: PartialWall) -> Bool {
        lhs.position == rhs.position
    }
}
