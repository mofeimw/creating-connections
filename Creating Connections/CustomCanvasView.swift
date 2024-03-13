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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("~~~~~~~~~~~~~~~~~~~~~~")
        for touch in touches {
            print("     !\(touch.force) ! \(touch.altitudeAngle * 180 / .pi)!")
            viewController?.infoLabel2.text = "Pressure: \(touch.force)"
            viewController?.infoLabel3.text = "Angle: \(touch.altitudeAngle * 180 / .pi)°"
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            print("     *\(touch.force) * \(touch.altitudeAngle * 180 / .pi)*")
            viewController?.infoLabel2.text = "Pressure: \(touch.force)"
            viewController?.infoLabel3.text = "Angle: \(touch.altitudeAngle * 180 / .pi)°"
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            print("     ~\(touch.force) ~ \(touch.altitudeAngle * 180 / .pi)~")
            viewController?.infoLabel2.text = "Pressure: \(touch.force)"
            viewController?.infoLabel3.text = "Angle: \(touch.altitudeAngle * 180 / .pi)°"
        }
    }
}
