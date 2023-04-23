//
//  EmptyTile.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct EmptyTile: Tile, InteractProtocol {
    var color: Color = .black
    var position: Position
    var playerId: UUID? = nil
    
    func onInteract(with key: KeyCode) -> [Position] {
        if playerId != nil {
            return interactAsWall(with: key)
        }
        return [self.position]
    }
}

extension EmptyTile {
    static func == (lhs: EmptyTile, rhs: EmptyTile) -> Bool {
        lhs.position == rhs.position
    }
}
