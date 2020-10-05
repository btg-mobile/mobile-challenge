import Foundation

public protocol HttpGetClient {
    func get(to url: URL)
}
