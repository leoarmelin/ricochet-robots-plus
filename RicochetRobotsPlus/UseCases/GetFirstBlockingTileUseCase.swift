//
//  GetFirstBlockingTileUseCase.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 23/04/23.
//

struct GetFirstBlockingTileUseCase {
    func getFirstBlockingTile(for list: [any Tile], with key: KeyCode, using player: Player) -> (any Tile)? {
        for tile in list {
            switch tile {
            case is Wall:
                return tile
            case let partialWall as PartialWall:
                if (partialWall.playerId != nil && partialWall.playerId != player.id) || partialWall.isBlockingMovement(for: key, player.position) {
                    return tile
                }
            case let emptyTile as EmptyTile:
                if emptyTile.playerId != nil && emptyTile.playerId != player.id {
                    return tile
                }
                
            case let trampoline as Trampoline:
                if (trampoline.playerId != player.id) {
                    return tile
                }

            default:
                continue
            }
        }
        
        return list.last
    }
}
