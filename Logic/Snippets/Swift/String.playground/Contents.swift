import UIKit

let str = "ABCDEFG12345"

// 文字列内の変数利用
print("str = \(str)")

// 一致判定
let strA = "ABC"
print(strA == ("ABC"))
print(strA.caseInsensitiveCompare("aBc") == .orderedSame)

// 長さ
print(str.count)

// 切り出し
let strAiueo = "あいうえお"
print(strAiueo.prefix(1)) // あ
print(strAiueo.suffix(1)) // お
print(strAiueo.dropFirst(1)) // いうえお（先頭からn番目までを削除）

let from = strAiueo.index(strAiueo.startIndex, offsetBy:1)
let to = strAiueo.index(strAiueo.startIndex, offsetBy:3)
print(String(strAiueo[from..<to])) // いう

// 検索
print(str.contains("ABC")) // true
print(str.hasPrefix("ABC")) // true
print(str.hasSuffix("45")) // true
print(str.range(of: "BC")) // Range

// 分割
let list = "A,B,C,D".split(separator: ",")
list.forEach{
    print($0)
}

// 結合
print("Honda" + "Kawasaki")

// 大文字小文字
print("abc".uppercased()) // ABC
print("ABC".lowercased()) // abc
// 先頭の文字列のみ
print("abc".capitalized) // Abc

// 置換
print(str.replacingOccurrences(of: "AB", with: "XXX"))

// 削除
print("abcd".replacingOccurrences(of:"ab", with:"")) // cd
print("abcd".dropLast(2)) // ab
print("abcd".dropFirst(2)) // cd

// 前後の空白を削除
var str2 = " ab cd "
print(str2.trimmingCharacters(in: .whitespaces)) // ab cd

// フォーマット
print(String(format: "%05d", 123)) // 00123
print(String(format: "%5d", 123)) //   123

// 数値に変換
let numStr = "123"
print(String(numStr))
