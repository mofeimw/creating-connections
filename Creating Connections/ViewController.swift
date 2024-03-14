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
    public var SPIRAL_COORDS : [[Double]] = []
    public var SPIRAL_ORIGIN = CGPoint(x: 0, y: 0)
    
    private struct Coordinates: Decodable {
        let coords: [[Double]]
    }
    
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
        
        loadSpiralCoords()
        
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
        SPIRAL_ORIGIN = CGPoint(x: spiralFrame.minX, y: spiralFrame.minY)
        print("Spiral Location\n---------------")
        print("Top Left: \(SPIRAL_ORIGIN)")
        print("Top Right: \(CGPoint(x: spiralFrame.maxX, y: spiralFrame.minY))")
        print("Bottom Left: \(CGPoint(x: spiralFrame.minX, y: spiralFrame.maxY))")
        print("Bottom Right: \(CGPoint(x: spiralFrame.maxX, y: spiralFrame.maxY))\n")
        
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
    
    func loadSpiralCoords() {
        do {
            if let filePath = Bundle.main.path(forResource: "spiral", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Coordinates.self, from: data)
                SPIRAL_COORDS = jsonData.coords
            }
        } catch {
            print("error: \(error)")
        }
    }
    
    func drawSpiralCoords() {
        for coord in SPIRAL_COORDS {
            let x = SPIRAL_ORIGIN.x + CGFloat(coord[0])
            let y = SPIRAL_ORIGIN.y + CGFloat(coord[1])
                
            let dotView = UIView(frame: CGRect(x: x, y: y, width: 2, height: 2))
            dotView.backgroundColor = .black
                
            view.addSubview(dotView)
        }
    }
    
    func moveSpiralCoords(x : Double, y : Double) {
        for (i, _) in SPIRAL_COORDS.enumerated() {
            SPIRAL_COORDS[i][0] += x;
            SPIRAL_COORDS[i][1] += y;
        }
    }
    
    func resizeSpiralCoords(factor : Double) {
        for (i, _) in SPIRAL_COORDS.enumerated() {
            SPIRAL_COORDS[i][0] *= factor;
            SPIRAL_COORDS[i][1] *= factor;
        }
    }
    
    @objc func clearCanvas(_ sender: UIButton) {
        canvasView.drawing = PKDrawing()
        
        infoLabel.text = "Creating Connections"
        infoLabel1.text = "Location:"
        infoLabel2.text = "Pressure:"
        infoLabel3.text = "Angle:"
    }
}
