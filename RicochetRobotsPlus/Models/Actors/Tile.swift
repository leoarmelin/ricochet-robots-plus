//
//  Tile.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

protocol Tile: Equatable {
    var color: Color { get }
    var position: Position { get set }
}

extension Tile {
    func isEqual(to tile2: any Tile) -> Bool {
        switch self {
        case let tile1 as EmptyTile:
            if let tile2Cast = tile2 as? EmptyTile {
                return tile1 == tile2Cast
            }
            return false
            
        case let tile1 as Wall:
            if let tile2Cast = tile2 as? Wall {
                return tile1 == tile2Cast
            }
            return false
            
        case let tile1 as PartialWall:
            if let tile2Cast = tile2 as? PartialWall {
                return tile1 == tile2Cast
            }
            return false
        default:
            return false
        }
    }
}

extension Array where Element == any Tile {
    func isEqual(to array2: [any Tile]) -> Bool {
        if self.count != array2.count {
            return false
        }

        for i in self.indices {
            if !self[i].isEqual(to: array2[i]) {
                return false
            }
        }

        return true
    }
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
