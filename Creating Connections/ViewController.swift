//
//  ViewController.swift
//  Creating Connections
//
//  Created by Mofei Wang on 3/4/24.
//

import UIKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate {
    
    private let canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(40)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvasView)
        view.addSubview(infoLabel)
        
        canvasView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        canvasView.frame = view.bounds
        infoLabel.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 50)
        infoLabel.text = "Creating Connections"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print("*\(touch.force)*")
        }
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let drawing = canvasView.drawing
        let lastStroke = drawing.strokes.last
        let path = lastStroke!.path
        
        let start_coords = path.first!.location
        let end_coords = path.last!.location
        let info = "\(start_coords) -> \(end_coords)"
        
        infoLabel.text = info
        
        print("~ " + info + " ~")
        print("==============")
        for point in path {
            print(point.location)
        }
        print("--------------\n\n")
    }
}
