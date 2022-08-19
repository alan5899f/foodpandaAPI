




import Foundation
import UIKit

extension UIImageView {
    
    func customModel(contentMode: UIView.ContentMode) -> UIImageView {
        self.contentMode = contentMode
        layer.masksToBounds = true
        return self
    }
}
