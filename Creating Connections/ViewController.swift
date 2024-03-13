//
//  ViewController.swift
//  Creating Connections
//
//  Created by Mofei Wang on 3/4/24.
//

import UIKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate {
    
    private let spiral = UIImageView(image: UIImage(named: "archimedean_spiral.png"))
    public var SPIRAL_TOP_LEFT = CGPoint(x: 0, y: 0)
    public var SPIRAL_TOP_RIGHT = CGPoint(x: 0, y: 0)
    public var SPIRAL_BOTTOM_LEFT = CGPoint(x: 0, y: 0)
    public var SPIRAL_BOTTOM_RIGHT = CGPoint(x: 0, y: 0)
    
    private lazy var canvasView: CustomCanvasView = {
        let canvas = CustomCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        return label
    }()
    
    public let infoLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        return label
    }()
    
    public let infoLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        return label
    }()
    
    public let infoLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        return label
    }()
    
    public let infoLabel4: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        button.addTarget(self, action: #selector(clearCanvas(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvasView)
        view.addSubview(infoLabel)
        view.addSubview(infoLabel1)
        view.addSubview(infoLabel2)
        view.addSubview(infoLabel3)
        view.addSubview(infoLabel4)
        view.addSubview(clearButton)
        view.addSubview(spiral)
        
        spiral.translatesAutoresizingMaskIntoConstraints = false
        spiral.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spiral.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        
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
        
        let spiralFrame = spiral.superview?.convert(spiral.frame, to: nil) ?? .zero
        SPIRAL_TOP_LEFT = CGPoint(x: spiralFrame.minX, y: spiralFrame.minY)
        SPIRAL_TOP_RIGHT = CGPoint(x: spiralFrame.maxX, y: spiralFrame.minY)
        SPIRAL_BOTTOM_LEFT = CGPoint(x: spiralFrame.minX, y: spiralFrame.maxY)
        SPIRAL_BOTTOM_RIGHT = CGPoint(x: spiralFrame.maxX, y: spiralFrame.maxY)
        print("Spiral Location\n---------------")
        print("Top Left: \(SPIRAL_TOP_LEFT)")
        print("Top Right: \(SPIRAL_TOP_RIGHT)")
        print("Bottom Left: \(SPIRAL_BOTTOM_LEFT)")
        print("Bottom Right: \(SPIRAL_BOTTOM_RIGHT)\n")
        
        canvasView.frame = view.bounds
        
        infoLabel.text = "Creating Connections"
        infoLabel.frame = CGRect(x: 0, y: 40, width: view.bounds.width, height: 50)
        
        infoLabel1.text = "Location:"
        infoLabel1.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 50)
        
        infoLabel2.text = "Pressure:"
        infoLabel2.frame = CGRect(x: 0, y: 120, width: view.bounds.width, height: 50)
        
        infoLabel3.text = "Angle:"
        infoLabel3.frame = CGRect(x: 0, y: 160, width: view.bounds.width, height: 50)
    }
    
    @objc func clearCanvas(_ sender: UIButton) {
        canvasView.drawing = PKDrawing()
    }
}
