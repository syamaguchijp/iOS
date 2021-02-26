import UIKit

class URLUtil {
    
    /// URLエンコードを行う。
    /// @return URLエンコード化された文字列
    static func encodeUrl(urlString: String?) -> String? {
        
        let custom = CharacterSet(charactersIn: "!\"\n#$%&'()-=^~|@`[]{};+:*,<>./?_").inverted
        if let urlString = urlString, let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: custom) {
            return encodedString
        }
        return nil
    }
    
    /// URLデコードを行う。
    /// @return URLデコード化された文字列
    static func decodeUrl(urlString: String?) -> String? {
        
        if let urlString = urlString, let decodedString = urlString.removingPercentEncoding {
            return decodedString
        }
        return nil
    }
}
