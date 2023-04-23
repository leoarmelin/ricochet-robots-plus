//
//  UpdateBoardTests.swift
//  RicochetRobotsPlusTests
//
//  Created by Leonardo Armelin on 22/04/23.
//

import XCTest

final class UpdateBoardTests: XCTestCase {
    private var updateBoardUseCase: UpdateBoardUseCase!
    private var board: [any Tile]!
    
    override func setUpWithError() throws {
        updateBoardUseCase = UpdateBoardUseCase()
        board = Boards.boardOne
    }

    func test_emptyTile() throws {
        // Operation to test
        var player: Player = .init(color: .blue, position: Position(x: 3, y: 0))
        let newPosition: Position = .init(x: 7, y: 0)

        updateBoardUseCase.update(&board, with: newPosition, using: player)
        player.position = newPosition
        
        
        let previousTile = board.first(where: { $0.position == Position(x: 3, y: 0) })
        let newTile = board.first(where: { $0.position == Position(x: 7, y: 0) })
        
        XCTAssertNil((previousTile as? EmptyTile)?.playerId)
        XCTAssertNotNil((newTile as? EmptyTile)?.playerId)
    }
    
    func test_partialWall() throws {
        // Operation to test
        let player: Player = .init(color: .blue, position: Position(x: 3, y: 0))
        let newPosition: Position = .init(x: 8, y: 0)

        updateBoardUseCase.update(&board, with: newPosition, using: player)
        
        let previousTile = board.first(where: { $0.position == Position(x: 3, y: 0) })
        let newTile = board.first(where: { $0.position == Position(x: 8, y: 0) })
        
        XCTAssertNil((previousTile as? EmptyTile)?.playerId)
        XCTAssertNotNil((newTile as? PartialWall)?.playerId)
    }
}
