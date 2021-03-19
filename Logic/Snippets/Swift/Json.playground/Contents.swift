import UIKit
 
// オブジェクト

struct User: Codable {
    var name: String
    var age: Int
    var birthday: Date
    var isMale: Bool
    var nickname: String?
}

// オブジェクトからJSONデータへ
let user = User(name: "Honda", age: 27, birthday: Date(), isMale: true, nickname: nil)
let encoder = JSONEncoder()
guard let jsonData = try? encoder.encode(user) else {
    fatalError("encode Error")
}

// JSONデータから文字列へ
let jsonString = String(bytes: jsonData, encoding: .utf8)
print(jsonString)

// 文字列からJSONデータへ
let jsonData2 = jsonString?.data(using: .utf8)

// JSONデータからオブジェクトへ
let decoder = JSONDecoder()
guard let user2: User = try? decoder.decode(User.self, from: jsonData2!) else {
    fatalError("decode Error")
}
print(user2)


// Dictionary

// DictionaryからJSONデータ、文字列へ
let dict = ["name": "Yamaha", "age": 18, "isMale": true] as [String : Any]
guard let dictData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
    fatalError("encode Error")
}
let dictString = String(bytes: dictData, encoding: .utf8)
print(dictString)

// 文字列からJSONデータ、Dictionaryへ
let dictData2 = dictString?.data(using: .utf8)
guard let dict2 = try? JSONSerialization.jsonObject(with: dictData2!) as? [String : Any] else {
    fatalError("decode Error")
}
print(dict2)
