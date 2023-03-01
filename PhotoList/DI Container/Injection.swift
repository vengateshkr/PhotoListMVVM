import Foundation
import Swinject

final class Injection {
    static let shared = Injection()
    var container: Container {
        get {
            if _container == nil {
                _container = buildContainer()
            }
            return _container!
        }
        set {
            _container = newValue
        }
    }
    
    private var _container : Container?
    
    private func buildContainer() -> Container {
        let container = Container()
        
        container.register(ConfigHelperProtocol.self) { _ in
             ConfigHelper()
        }
        container.register(RestClientProtocol.self) { _ in
            RestClient()
        }
        container.register(PhotoListViewModelProtocol.self) { _ in
            PhotoListViewModel()
        }
        container.register(DetailsViewModelProtocol.self) { _ in
            DetailsViewModel()
        }
        return container
    }
    
}
