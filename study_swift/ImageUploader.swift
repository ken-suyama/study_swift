import UIKit

typealias HTTPHeaders = [String: String]

final class ImageUploader {

    static func createHttpBody(binaryData: Data, content: String, mimeType: String, boundary: String) -> Data {
        var postContent = "--\(boundary)\r\n"
        let fileName = "\(UUID().uuidString).jpeg"
        postContent += "Content-Disposition: form-data; name=image; filename=\"\(fileName)\"\r\n"
        postContent += "Content-Type: \(mimeType)\r\n\r\n"

        var data = Data()
        guard let postData = postContent.data(using: .utf8) else { return data }
        data.append(postData)
        data.append(binaryData)

        var parameter = ""
        parameter += "\r\n--\(boundary)\r\n"
        parameter += "Content-Disposition: form-data; name=content\r\n\r\n"
        parameter += content
        if let postData = parameter.data(using: .utf8) { data.append(postData) }

        // HTTPBodyの終了を設定
        guard let endData = "\r\n--\(boundary)--\r\n".data(using: .utf8) else { return data }
        data.append(endData)
        return data
    }
}
