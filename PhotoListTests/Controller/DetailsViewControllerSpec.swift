@testable import PhotoList
import Quick
import Nimble
import UIKit

extension UIViewController {
    func renderView() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                window.rootViewController = self
                RunLoop.main.run(until: Date())
            }
        }
    }
}

class DetailsViewControllerSpec: QuickSpec {
    override func spec() {
        let vm = MockDetailsViewModel()
        let sut = DetailsViewController(viewModel: vm)
        
        describe("On DetailView Controller load") {
            beforeEach {
                sut.renderView()
            }
            
            it("should show the title as 'Photo Details'") {
                let actual = await sut.title
                expect(actual).to(equal("Photo Details"))
            }
            it("should show the title label as 'title'") {
                let actual = await sut.titleLabel.text
                expect(actual).to(equal("title"))
            }
            it("should show the ID label as 'ID'") {
                let actual = await sut.descriptionLabel.text
                expect(actual).to(equal("ID"))
            }
        }
    }
}

class MockDetailsViewModel: DetailsViewModelProtocol {
    var photoData: PhotoList.Observable<PhotoList.PhotoModel>? = Observable<PhotoList.PhotoModel>(nil)
    var wasMakeImageURLCalled = false
    
    func selectedPhoto(_ photo: PhotoList.PhotoModel) {
        photoData?.value = photo
    }
    
    func makeImageURL() -> URL? {
        self.wasMakeImageURLCalled = true
        return URL(string: "https://google.com")
    }
    
    func makeTitle() -> String {
        return "title"
    }
    
    func makeID() -> String {
        return "ID"
    }
}
