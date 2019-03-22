import UIKit
import SpriteKit

class Snake : SKShapeNode {
    var body = [SnakeBodyPart]()
    let moveSpeed = 125.0
    var angle: CGFloat = 0.0
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }
    
    func addBodyPart(){
        let newBodyPart = SnakeBodyPart(atPoint: body[body.count-1].position)
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move() {
        guard !body.isEmpty else { return }
        let head = body[0]
        moveHead(head: head)
        for index in 0..<body.count where index > 0 {
            let previous = body[index - 1]
            let current = body[index]
            moveBodyPart(p: previous, c: current)
        }
    }
    
    func moveClockwise() {
        angle += CGFloat(Double.pi/2)
    }
    
    func moveCounterClockwise() {
        angle -= CGFloat(Double.pi/2)
    }
    
    func moveHead(head: SnakeBodyPart) {
        let dx = CGFloat(moveSpeed) * sin(angle)
        let dy = CGFloat(moveSpeed) * cos(angle)
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    func moveBodyPart(p: SnakeBodyPart, c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        c.run(moveAction)
    }
}
