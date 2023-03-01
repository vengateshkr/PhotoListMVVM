
import XCTest
import Nimble

final class PhotoListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments += ["UITests", "-reset"]
        app.launch()
    }
    
    override func tearDown() { }

    func testPhotoListApp() {
        
        testListScreen()
        
        testNavigationtoDetailScreen()
    }
    
    fileprivate func testListScreen() {
        expect(self.app.staticTexts["Photo List"].exists).toEventually(beTrue())
        let myTableRow19 = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
        _ = myTableRow19.cells.element(matching: .cell, identifier: "myCell_19")
        expect(self.app.staticTexts["assumenda voluptatem laboriosam enim consequatur veniam placeat reiciendis error"].exists).toEventually(beTrue())
    }
    
    fileprivate func testNavigationtoDetailScreen() {
        let myTableRow1 = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
        let cell1 = myTableRow1.cells.element(matching: .cell, identifier: "myCell_1")
        cell1.tap()
        expect(self.app.staticTexts["ID : 2"].exists).toEventually(beTrue())
        expect(self.app.staticTexts["reprehenderit est deserunt velit ipsam"].exists).toEventually(beTrue())
        app.buttons["Photo List"].tap()
        
        let myTableRow15 = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
        let cell15 = myTableRow15.cells.element(matching: .cell, identifier: "myCell_15")
        cell15.tap()
        
        expect(self.app.staticTexts["ID : 16"].exists).toEventually(beTrue())
        expect(self.app.staticTexts["iusto sunt nobis quasi veritatis quas expedita voluptatum deserunt"].exists).toEventually(beTrue())
        app.buttons["Photo List"].tap()
        
        
        let myTableRow18 = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
        let cell18 = myTableRow18.cells.element(matching: .cell, identifier: "myCell_18")
        cell18.tap()
        
        expect(self.app.staticTexts["ID : 19"].exists).toEventually(beTrue())
        expect(self.app.staticTexts["perferendis nesciunt eveniet et optio a"].exists).toEventually(beTrue())
        app.buttons["Photo List"].tap()
    }
    
}
