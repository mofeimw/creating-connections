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
            print("\(touch.location(in: self)) - \(touch.force) - \(touch.altitudeAngle * 180 / .pi), \(touch.azimuthAngle(in: self) * 180 / .pi) - \(touch.timestamp)")
            
            viewController?.infoLabel1.text = "Location: \(touch.location(in: self))"
            viewController?.infoLabel2.text = "Pressure: \(touch.force)"
            viewController?.infoLabel3.text = "Angle: \(touch.altitudeAngle * 180 / .pi)°, \(touch.azimuthAngle(in: self) * 180 / .pi)°"
            
            pointMapper(point: touch.location(in: self))
        }
    }
    
    func pointMapper(point : CGPoint) {
        let spiral_origin = viewController?.SPIRAL_TOP_LEFT
        
        let origin = CGPoint(x: spiral_origin!.x + 273.7, y: spiral_origin!.y + 248.4)
        let last = CGPoint(x: spiral_origin!.x + 592.9, y: spiral_origin!.y + 248.4)
        
        if (closeEnough(p1: origin.x, p2: point.x) && closeEnough(p1: origin.y, p2: point.y)) {
            viewController?.infoLabel.text = "You're at the startpoint"
        } else if (closeEnough(p1: last.x, p2: point.x) && closeEnough(p1: last.y, p2: point.y)) {
            viewController?.infoLabel.text = "You're at the endpoint"
        } else {
            viewController?.infoLabel.text = "Creating Connections"
        }
    }
    
    func closeEnough(p1: CGFloat, p2: CGFloat) -> Bool {
        return abs(p1 - p2) <= 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("~~~~~~~~~~~~~~~~~ \(i) ~~~~~~~~~~~~~~~~~~~")
        print("------- Max Possible Force: \(touches.first!.maximumPossibleForce) -------")
        print("- coords, pressure, angles, timestamp -")
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
