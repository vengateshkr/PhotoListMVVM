

import Foundation

class PhotoListTableCellViewModel {
    var id: Int
    var title: String
    var albumId: Int
    var url: URL?
    var thumbnailUrl: URL?
    
    init(model: PhotoModel) {
        self.id = model.id ?? 0
        self.title = model.title ?? ""
        self.albumId = model.albumId ?? 0
        self.url = makeImageURL(model.url ?? "")
        self.thumbnailUrl = makeThumbImageURL(model.thumbnailUrl ?? "")
    }
    
    private func makeImageURL(_ str: String) -> URL? {
        URL(string: str)
    }
    
    private func makeThumbImageURL(_ str: String) -> URL? {
        URL(string: str)
    }
}
