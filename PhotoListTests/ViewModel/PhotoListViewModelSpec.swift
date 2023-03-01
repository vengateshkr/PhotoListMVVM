import Foundation
@testable import PhotoList
import Quick
import Nimble
import UIKit

class PhotoListViewModelSpec: QuickSpec {

    override func spec()  {
        let mockRestClient = MockRestClient()
        let sut = PhotoListViewModel(restClient:mockRestClient)
              
        describe("number of cells") {
            beforeEach {
                sut.photosArr = [PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumbUrl")]
            }
            
            it("should return 1") {
                let actual = sut.numberOfRows()
                expect(actual).to(equal(1))
            }
        }
        describe("On getTitle function") {
            var idStr: String!
            beforeEach {
                idStr = sut.getTitle(PhotoModel(albumId: 1, id: 1234, title: "title_123", url: "url", thumbnailUrl: "thumbUrl"))
            }
            
            it("should return 1") {
                expect(idStr).to(equal("title_123"))
            }
        }
        describe("On retrivePhoto function") {
            beforeEach {
                sut.photosArr = [PhotoModel(albumId: 333, id: 1234, title: "title_123", url: "url", thumbnailUrl: "thumbUrl")]
            }
            it("should return albumId as expected value") {
                let phModel = sut.retrivePhoto(withId: 1234)
                expect(phModel?.albumId).to(equal(333))
            }
            beforeEach {
                sut.photosArr = [PhotoModel(albumId: 333, id: 1234, title: "title_123", url: "url", thumbnailUrl: "thumbUrl")]
            }
            it("should return albumId as expected value") {
                let phModel = sut.retrivePhoto(withId: 123)
                expect(phModel?.albumId).to(beNil())
            }
        }
        describe("On GETAPI function called") {
            beforeEach {
                sut.callPhotoListAPI()
            }
            it("Get should be called and should return true") {
                expect(mockRestClient.wasGETCalled).to(beTrue())
            }
        }
    }
}

class MockRestClient: RestClientProtocol {
    
    var wasGETCalled = false
    
    func GET(urlString: String?, complete: @escaping (Bool, [PhotoList.PhotoModel]?) -> ()) {
        wasGETCalled = true
    }
}
