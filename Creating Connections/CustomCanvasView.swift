//
//  CustomCanvasView.swift
//  Creating Connections
//
//  Created by Mofei Wang on 3/12/24.
//

import UIKit
import PencilKit

class CustomCanvasView: PKCanvasView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            print("!\(touch.force)!")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            print("*\(touch.force)*")
        }
    }
}
