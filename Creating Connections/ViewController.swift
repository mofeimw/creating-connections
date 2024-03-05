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
    
    // MARK: - PKCanvasViewDelegate
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let drawing = canvasView.drawing
        let lastStroke = drawing.strokes.last
        let path = lastStroke!.path
        
        let start_coords : String = "\(path.first!.location)"
        let end_coords : String = "\(path.last!.location)"
        infoLabel.text = start_coords + " -> " + end_coords
        
        print("START:")
        print(start_coords)
        print("END:")
        print(end_coords)
        print("---")
    }
}
