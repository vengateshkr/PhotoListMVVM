
import Foundation

protocol DetailsViewModelProtocol {
    func selectedPhoto(_ photo: PhotoModel)
    var photoData: Observable<PhotoModel>? {get}
    func makeImageURL() -> URL?
    func makeTitle() -> String
    func makeID() -> String
}

class DetailsViewModel : DetailsViewModelProtocol {
    var photoData: Observable<PhotoModel>? = Observable(nil)
   
    func selectedPhoto(_ photo: PhotoModel) {
        self.photoData?.value = photo
    }
    
    func makeImageURL() -> URL? {
        URL(string: self.photoData?.value?.url ?? "")
    }
    
    func makeTitle() -> String {
        self.photoData?.value?.title ?? ""
    }
    
    func makeID() -> String {
        "ID : \(self.photoData?.value?.id ?? 0)"
    }
}
