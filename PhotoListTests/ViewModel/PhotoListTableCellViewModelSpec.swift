@testable import PhotoList
import Quick
import Nimble

class PhotoListTableCellViewModelSpec: QuickSpec {
    override func spec() {
        let model = PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumbUrl")
        let sut = PhotoListTableCellViewModel(model: model)

        describe("PhotoListTableCellViewModel is checked") {
            it("should be not nil") {
                expect(sut).toNot(beNil())
            }
            it("should return makeImageURL is 'url'") {
                expect(sut.url).to(equal(URL(string: "url")))
            }
            it("should return makeThumbImageURL is 'thumbUrl'") {
                expect(sut.thumbnailUrl).to(equal(URL(string: "thumbUrl")))
            }
        }
    }
}
