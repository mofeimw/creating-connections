//
//  CustomCanvasView.swift
//  Creating Connections
//
//  Created by Mofei Wang on 3/12/24.
//

import UIKit
import PencilKit

class CustomCanvasView: PKCanvasView {
    
    weak var viewController: ViewController?
    
    private var i = 1
    
    func processTouch(touches: Set<UITouch>) {
        for touch in touches {
            let closest = pointMapper(point: touch.location(in: self))
            
            print("\(touch.location(in: self)) - \(closest) - \(touch.force) - \(touch.altitudeAngle * 180 / .pi), \(touch.azimuthAngle(in: self) * 180 / .pi) - \(round(1000 * touch.timestamp) / 1000)")
            
            viewController?.infoLabel1.text = "Location: \(touch.location(in: self))"
            viewController?.infoLabel2.text = "Pressure: \(touch.force)"
            viewController?.infoLabel3.text = "Angle: \(touch.altitudeAngle * 180 / .pi)°, \(touch.azimuthAngle(in: self) * 180 / .pi)°"
        }
    }
    
    func pointMapper(point : CGPoint) -> Double {
        let SPIRAL_ORIGIN = viewController?.SPIRAL_ORIGIN
        let SPIRAL_COORDS = viewController!.SPIRAL_COORDS
        
        var closeFlag = false
        var closest = 1000000000000000.0
        
        for coord in SPIRAL_COORDS {
            let spiral_point = CGPoint(x: SPIRAL_ORIGIN!.x + coord.first!, y: SPIRAL_ORIGIN!.y + coord.last!)
            let distance = CGPointDistance(from: point, to: spiral_point)
            
            if (distance < closest) {
                closest = distance
            }
            
            if (distance < 8.0) {
                closeFlag = true
            }
        }
        
        closest = Double(round(100 * (closest - 8.0)) / 100)
        
        if (closeFlag) {
            viewController?.infoLabel.text = "You're on the line!"
            closest = 0.00
        } else {
            viewController?.infoLabel.text = "You're \(closest) away from the line"
        }
        
        return closest
    }
    
    func closeEnough(p1: CGFloat, p2: CGFloat) -> Bool {
        return abs(p1 - p2) <= 10
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("~~~~~~~~~~~~~~~~~ \(i) ~~~~~~~~~~~~~~~~~~~")
        print("------- Max Possible Force: \(touches.first!.maximumPossibleForce) -------")
        print("- coords, distance, pressure, angles, timestamp-")
        processTouch(touches: touches)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        processTouch(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        processTouch(touches: touches)
        print("~~~~~~~~~~~~~~~~~ \(i) ~~~~~~~~~~~~~~~~~~~\n")
        i += 1
    }
}
