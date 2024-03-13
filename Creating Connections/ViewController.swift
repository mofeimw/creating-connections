//
//  ViewController.swift
//  Creating Connections
//
//  Created by Mofei Wang on 3/4/24.
//

import UIKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate {
    
    private lazy var canvasView: CustomCanvasView = {
        let canvas = CustomCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        return label
    }()
    
    public let infoLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        return label
    }()
    
    public let infoLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear Canvas", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        button.addTarget(self, action: #selector(clearCanvas(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvasView)
        view.addSubview(infoLabel)
        view.addSubview(infoLabel2)
        view.addSubview(infoLabel3)
        view.addSubview(clearButton)
        
        let spiral = UIImageView(image: UIImage(named: "archimedean_spiral.png"))
        view.addSubview(spiral)
        spiral.translatesAutoresizingMaskIntoConstraints = false
        spiral.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spiral.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            clearButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            clearButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        canvasView.viewController = self
        canvasView.delegate = self
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 7)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        canvasView.frame = view.bounds
        
        infoLabel.text = "Creating Connections"
        infoLabel.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: 50)
        
        infoLabel2.text = "Prototype v1.4"
        infoLabel2.frame = CGRect(x: 0, y: 120, width: view.bounds.width, height: 50)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        infoLabel3.frame = CGRect(x: 0, y: 180, width: view.bounds.width, height: 50)
        infoLabel3.text = dateString
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let drawing = canvasView.drawing
        let lastStroke = drawing.strokes.last
        if (lastStroke == nil) {
            return
        }
        let path = lastStroke!.path
        
        let start_coords = path.first!.location
        let end_coords = path.last!.location
        let info = "\(start_coords) -> \(end_coords)"
        
        infoLabel.text = info
        
        print("    --------------")
        print("    \(start_coords)\n          ->\n    \(end_coords)")
        print("    ==============")
        for point in path {
            print("   ", point.location)
        }
        print("~~~~~~~~~~~~~~~~~~~~~~\n\n")
    }
    
    @objc func clearCanvas(_ sender: UIButton) {
        canvasView.drawing = PKDrawing()
        infoLabel.text = "Canvas Cleared"
    }
}
