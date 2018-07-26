import UIKit

// MARK: Color

enum Alpha {
    static let clear: CGFloat = 0
    static let disabled: CGFloat = 0.3
    static let highlighted: CGFloat = 0.45
    static let opaque: CGFloat = 1
}

func rgb(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat = Alpha.opaque) -> UIColor {
    return Rgb.make(CGFloat(r), CGFloat(g), CGFloat(b), a)
}

private enum Rgb {
    static let min: CGFloat = 0
    static let max: CGFloat = 255
    static func make(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r / max, green: g / max, blue: b / max, alpha: a)
    }
}

// MARK: NumConst

enum NumConst {
    static let attached: CGFloat = 0
    static let same: CGFloat = 1
    
    static let defaultParseInt = 0
    static let defaultParseFloat: CGFloat = 0
}

// MARK: Device

var appWindow: UIWindow? {
    return (UIApplication.shared.delegate)?.window!
}

enum Screen {
    static var main: UIScreen { return .main }
    static var bounds: CGRect { return main.bounds }
    static var scale: CGFloat { return main.scale }
}
