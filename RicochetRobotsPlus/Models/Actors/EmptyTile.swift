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
    
    func onInteract(with key: KeyCode, for player: Player) -> [Position] {
        if playerId != nil && playerId != player.id {
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
