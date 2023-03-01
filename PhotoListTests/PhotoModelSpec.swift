@testable import PhotoList
import Quick
import Nimble

class PhotoModelSpec: QuickSpec {
    var sut = PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumbUrl")
    override func spec() {
        describe("PhotoModel is checked") {
            it("should be not nil") {
                expect(self.sut).toNot(beNil())
            }
        }
    }
}
