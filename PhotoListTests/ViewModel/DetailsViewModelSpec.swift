import Foundation
@testable import PhotoList
import Quick
import Nimble
import UIKit

class DetailsViewModelSpec: QuickSpec {

    override func spec()  {
        let sut = DetailsViewModel()
              
        describe("On DetailViewmodel initialization check") {
            beforeEach {
                sut.selectedPhoto(PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumburl"))
            }
            
            it("should return the description as 'title'") {
                let actual =  sut.makeTitle()
                expect(actual).to(equal("title"))
            }
            it("should return the ID as 'ID : '") {
                let actual =  sut.makeID()
                expect(actual).to(equal("ID : 1"))
            }
            it("should return the url as 'url'") {
                let actual =  sut.makeImageURL()
                expect(actual).to(equal(URL(string: "url")))
            }
        }
    }
}
