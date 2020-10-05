import Foundation

public final class RemoteListQuotes {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func list() {
        httpClient.get(to: url)
    }
}
