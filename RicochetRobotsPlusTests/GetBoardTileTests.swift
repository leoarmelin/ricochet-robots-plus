//
//  GetBoardTileTests.swift
//  RicochetRobotsPlusTests
//
//  Created by Leonardo Armelin on 22/04/23.
//

import XCTest

final class GetBoardTileTests: XCTestCase {
    private var getBoardTileUseCase: GetBoardTileUseCase!
    private var board: [any Tile]!
    
    override func setUpWithError() throws {
        getBoardTileUseCase = GetBoardTileUseCase()
        board = Boards.boardOne
    }

    func test_emptyTile() throws {
        // Operation to test
        let tile = getBoardTileUseCase.getTile(for: board, on: Position(x: 0, y: 0))
        
        let expectedResponse: any Tile = EmptyTile(position: .init(x: 0, y: 0))
        
        XCTAssertTrue(tile.isEqual(to: expectedResponse))
    }
    
    func test_partialWall() throws {
        // Operation to test
        let tile = getBoardTileUseCase.getTile(for: board, on: Position(x: 9, y: 14))
        
        let expectedResponse: any Tile = PartialWall(position: .init(x: 9, y: 14), sidesBlock: [.top, .right])
        
        XCTAssertTrue(tile.isEqual(to: expectedResponse))
    }
    
    func test_wall() throws {
        // Operation to test
        let tile = getBoardTileUseCase.getTile(for: board, on: Position(x: 7, y: 8))
        
        let expectedResponse: any Tile = Wall(position: .init(x: 7, y: 8))
        
        XCTAssertTrue(tile.isEqual(to: expectedResponse))
    }
    
    func test_wrongPosition() throws {
        // Operation to test
        let tile = getBoardTileUseCase.getTile(for: board, on: Position(x: 2, y: 3))
        
        let expectedResponse: any Tile = Wall(position: .init(x: 7, y: 8))
        
        XCTAssertFalse(tile.isEqual(to: expectedResponse))
    }
    
    func test_wrongType() throws {
        // Operation to test
        let tile = getBoardTileUseCase.getTile(for: board, on: Position(x: 2, y: 3))
        
        let expectedResponse: any Tile = Wall(position: .init(x: 2, y: 3))
        
        XCTAssertFalse(tile.isEqual(to: expectedResponse))
    }
}
