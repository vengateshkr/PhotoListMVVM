import Foundation


protocol RestClientProtocol {
    func GET(urlString: String?, complete: @escaping (Bool, [PhotoModel]?) -> ())
}


class RestClient: RestClientProtocol {
    
    let configHelper: ConfigHelperProtocol
    
    init(configHelper: ConfigHelperProtocol = Injection.shared.container.resolve(ConfigHelperProtocol.self)!) {
        self.configHelper = configHelper
    }
    
    func GET(urlString: String?, complete: @escaping (Bool, [PhotoModel]?) -> ()) {
    
        var gatewayBaseUrl  = configHelper.getUrl(key: "base_url") ?? ""
        gatewayBaseUrl = "\(gatewayBaseUrl)" + "\(urlString ?? "")"
        
        guard let url = URL(string: gatewayBaseUrl) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            let photoResp = try? JSONDecoder().decode(
                [PhotoModel]?.self,
                from: data
            )

            complete(true, photoResp)
        }.resume()
    }
}
