import Nest


public struct Request : RequestType, CustomStringConvertible, CustomDebugStringConvertible {
  public var method:String
  public var path:String
  public var headers:[Header]
  public var body:String?
  public var params:[String:String]

  public init(method:String, path:String, headers:[Header]? = nil, body:String? = nil) {
    self.method = method
    self.path = path
    self.headers = headers ?? []
    self.body = body
    self.params = [:]
  }

  public var description:String {
    return "\(method) \(path)"
  }

  public var debugDescription:String {
    let request = ["\(method) \(path)"] + headers.map { "\($0) \($1)" }
    return request.joinWithSeparator("\n")
  }
}


extension RequestType {
  public subscript(header: String) -> String? {
    get {
      return headers.filter { $0.0.lowercaseString == header.lowercaseString }.first?.1
    }
  }

  /// Returns the Host header
  public var host:String? {
    return self["Host"]
  }

  /// Returns the Content-Type header
  public var contentType:String? {
    return self["Content-Type"]
  }

  /// Returns the Content-Length header
  public var contentLength:Int? {
    if let contentLength = self["Content-Length"] {
      return Int(contentLength)
    }

    return nil
  }

  /// Returns the Accept header
  public var accept:String? {
    return self["Accept"]
  }

  /// Returns the Authorization header
  public var authorization:String? {
    return self["Authorization"]
  }
}
