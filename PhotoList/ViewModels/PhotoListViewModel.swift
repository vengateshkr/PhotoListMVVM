import Foundation
import UIKit
import SDWebImage

protocol PhotoListViewModelProtocol {
    func callPhotoListAPI()
    func numberOfRows() -> Int?
    var photosArr: [PhotoModel] {get}
    var isLoadingData: Observable<Bool> {get set}
    var photos: Observable<[PhotoListTableCellViewModel]>{get}
    func getTitle(_ photo: PhotoModel) -> String
    func retrivePhoto(withId id: Int) -> PhotoModel?
    var shouldShowError: Observable<Bool> {get set}
}


class PhotoListViewModel: PhotoListViewModelProtocol {    
    let restClient: RestClientProtocol
    var photosArr = [PhotoModel]()
    var isLoadingData: Observable<Bool> = Observable(false)
    var photos: Observable<[PhotoListTableCellViewModel]> = Observable(nil)
    var shouldShowError: Observable<Bool> = Observable(false)

    init(restClient: RestClientProtocol = Injection.shared.container.resolve(RestClientProtocol.self)!) {
        self.restClient = restClient
    }
    
    func callPhotoListAPI() {
        photosArr.removeAll()
        self.isLoadingData.value = true
        restClient.GET(urlString: "photos") { [weak self] isSuccess, photoResp in
            self?.isLoadingData.value = false
            if isSuccess {
                self?.photosArr = photoResp ?? []
                self?.mapData()
            } else {
                self?.shouldShowError.value = true
            }
        }
    }
    
    func numberOfRows() -> Int? {
        return photosArr.count
    }
    
    private func mapData() {
        photos.value = self.photosArr.compactMap({PhotoListTableCellViewModel(model: $0)})
    }
    
    func getTitle(_ photo: PhotoModel) -> String {
         photo.title ?? ""
    }
    
    func retrivePhoto(withId id: Int) -> PhotoModel? {
        guard let photo = photosArr.first(where: {$0.id == id}) else {
            return nil
        }

        return photo
    }
}
