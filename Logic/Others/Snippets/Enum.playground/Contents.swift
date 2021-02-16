import UIKit

enum EnumSample: Int {
    
    case sunday = 0
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

print("EnumSample.monday = \(EnumSample.monday)") // case名 monday
print("EnumSample.monday = \(EnumSample.monday.rawValue)") // case名に対応するInteger
