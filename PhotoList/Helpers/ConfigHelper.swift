import Foundation

protocol ConfigHelperProtocol {
    func getValue(key: String) -> String?
    func getUrl(key: String) -> String?
}

class ConfigHelper: ConfigHelperProtocol {
 
    func getValue(key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)
    }

    func getUrl(key: String) -> String? {
        return getValue(key: key)?.replacingOccurrences(of: "\\", with: "")
    }
}
