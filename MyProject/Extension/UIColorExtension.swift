import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    static let greenMint1 = UIColor(hex: 0x3C7363)
    static let greenMint2 = UIColor(hex: 0x8FD9C4)
    static let greenMint3 = UIColor(hex: 0xB8D9D0)
    static let greenMint4 = UIColor(hex: 0x84D9BA)
    static let greenMint5 = UIColor(hex: 0xE8F1FD)
}
