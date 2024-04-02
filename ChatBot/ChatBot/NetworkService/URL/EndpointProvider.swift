import Foundation

struct EndPoint: EndpointProvidable {
    private let apiHost: String
    private let urlInformation: URLInformation
    private let scheme: String
    
    init(urlInformation: URLInformation, apiHost: APIHostType, scheme: SchemeType) {
        self.urlInformation = urlInformation
        self.apiHost = apiHost.rawValue
        self.scheme = scheme.rawValue
    }
    
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = apiHost
        urlComponent.path = urlInformation.path
        if urlInformation.queryItems != nil {
            urlComponent.queryItems = urlInformation.queryItems
        }
        return urlComponent.url
    }
}

