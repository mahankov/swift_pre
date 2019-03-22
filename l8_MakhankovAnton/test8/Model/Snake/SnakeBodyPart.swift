import UIKit
import SpriteKit

class SnakeBodyPart : SKShapeNode {
    let diameter = 10.0
    static var partsCount: Int = 0
    init(atPoint point: CGPoint) {
        super.init()
        SnakeBodyPart.partsCount += 1
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        fillColor = UIColor.green
        strokeColor = UIColor.green
        lineWidth = 5
        name = String(SnakeBodyPart.partsCount)
        self.position = point
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 4), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnakeHead : SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Snake | CollisionCategories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
