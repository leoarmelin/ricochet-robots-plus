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
            case let castedTile as PartialWall:
                if (castedTile.playerId != nil && castedTile.playerId != player.id) || castedTile.isBlockingMovement(for: key, player.position) {
                    return tile
                }
            case let emptyTile as EmptyTile:
                if emptyTile.playerId != nil && emptyTile.playerId != player.id {
                    return tile
                }

            default:
                continue
            }
        }
        
        return list.last
    }
}
