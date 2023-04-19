//
//  Tile.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

protocol Tile {
    var color: Color { get }
    var position: Position { get set }
}

extension Tile {
    func interactAsWall(with key: KeyCode) -> [Position] {
        switch key {
        case .arrowUp:
            return [Position(x: self.position.x, y: self.position.y + 1)]
        case .arrowDown:
            return [Position(x: self.position.x, y: self.position.y - 1)]
        case .arrowLeft:
            return [Position(x: self.position.x + 1, y: self.position.y)]
        case .arrowRight:
            return [Position(x: self.position.x - 1, y: self.position.y)]
        }
    }
}
