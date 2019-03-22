import SpriteKit
import UIKit

class GameCounter: SKLabelNode {
    var curCount: Int = 1
    convenience init(position: CGPoint){
        self.init()
        self.position = position
        color = UIColor.white
        fontSize = 100
        text = String(curCount)
        horizontalAlignmentMode = .center
    }
    func addCount() {
        curCount += 1
        self.text = String(curCount)
    }
    func reset() {
        curCount = 0
        self.text = "1"
    }
}
