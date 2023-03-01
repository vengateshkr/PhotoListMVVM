import Foundation
@testable import PhotoList
import Quick
import Nimble
import UIKit

class PhotoListViewControllerSpec: QuickSpec {

    override func spec()  {
        let vm = MockPhotoListViewModel()
        let sut = PhotoListViewController(viewModel: vm)
              
        describe("On DetailView Controller load") {
            beforeEach {
                await sut.renderView()
            }
            
            it("should show the title as 'Photo Details'") {
                let actual = await sut.title
                expect(actual).to(equal("Photo List"))
            }
            
            it("should have consumed API on load") {
                expect(vm.shouldShowError.value).to(beTrue())
            }
            
            it("tableview should show one row") {
                let actual = await sut.photoListTableView.numberOfRows(inSection: 0)
                expect(actual).to(equal(1))
            }
        }
        describe("On tapping cell") {
            beforeEach {
                await sut.renderView()
                let model = PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumbUrl")
                var pd = await sut.photosDataSource
                pd = [PhotoListTableCellViewModel(model: model)]
            }
            
            it("should navigate to 'Photo Details'") {
                await sut.photoListTableView.tapOn(row: 0)
                guard let actual = await sut.navigationController?.topViewController else {return}
                await expect(actual).toEventually(beAnInstanceOf(DetailsViewController.self))
            }
        }
    }
}


extension UITableView {
    func tapOn(row: Int, inSection section: Int = 0) {
        self.delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: section))
    }
}


class MockPhotoListViewModel: PhotoListViewModelProtocol {
    
    var wasCallPhotoListAPI = false
        
    var photosArr: [PhotoList.PhotoModel] = []
    
    var isLoadingData : PhotoList.Observable<Bool> =  PhotoList.Observable(true)
    
    var photos: PhotoList.Observable<[PhotoList.PhotoListTableCellViewModel]> = PhotoList.Observable([PhotoListTableCellViewModel(model: PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumburl"))])
    
    var shouldShowError: PhotoList.Observable<Bool> =  PhotoList.Observable(true)

    func callPhotoListAPI() {
         wasCallPhotoListAPI = true
    }
    
    func numberOfRows() -> Int? {
        return 1
    }
    
    func getTitle(_ photo: PhotoList.PhotoModel) -> String {
        return "Title"
    }
    
    func retrivePhoto(withId id: Int) -> PhotoList.PhotoModel? {
        return PhotoModel(albumId: 1, id: 1, title: "title", url: "url", thumbnailUrl: "thumburl")
    }
}
