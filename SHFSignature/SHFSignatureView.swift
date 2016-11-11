//
//  SHFSignatureView.swift
//  SHFSignature
//
//  Created by Felipe Henrique Santolim on 11/10/16.
//
//

import UIKit

@IBDesignable
class SHFSignatureView: UIView {
    
    var delegate: SHFSignatureProtocol!
    
    //MARK: - IBInspectable
    @IBInspectable var bgSignatureView: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = bgSignatureView
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet {
            self.bezierPath.lineWidth = lineWidth
        }
    }
    
    //MARK: - Private porperties
    fileprivate var bezierPath      : UIBezierPath  = UIBezierPath()
    fileprivate var controlPoint    : Int           = 0
    fileprivate var points                          = [CGPoint](repeating: CGPoint(), count: 5)
    
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bezierPath.lineWidth       = self.lineWidth
        self.bezierPath.lineJoinStyle   = .round
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.bezierPath.stroke()
    }
    
    //MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        
        self.controlPoint   = 0
        self.points[0]      = touchPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        
        self.controlPoint               += 1
        self.points[self.controlPoint]  = touchPoint
        
        if self.controlPoint == 4 {
            
            self.points[3] = CGPoint(
                x: (self.points[2].x + self.points[4].x)/2.0,
                y: (self.points[2].y + self.points[4].y)/2.0)
            
            self.bezierPath.move(to: self.points[0])
            
            self.bezierPath.addCurve(
                to: self.points[3],
                controlPoint1:self.points[1],
                controlPoint2:self.points[2])
            
            self.setNeedsDisplay()
            
            self.points[0]      = self.points[3]
            self.points[1]      = self.points[4]
            
            self.controlPoint   = 1
        }
        
        if let delegate = self.delegate { delegate.drawingSignature() }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.controlPoint == 0 {
            let touchPoint = self.points[0]
            
            self.bezierPath.move(to: CGPoint(
                x: touchPoint.x-1.0,
                y: touchPoint.y))
            
            self.bezierPath.addLine(to: CGPoint(
                x: touchPoint.x+1.0,
                y: touchPoint.y))
            
            self.setNeedsDisplay()
            
        } else { self.controlPoint = 0 }
        
        if let delegate = self.delegate { delegate.image(self.image()) }
    }
}

extension SHFSignatureView {
    
    func clear () {
        
        self.bezierPath.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    fileprivate func image () -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 1.0)
        self.bezierPath.stroke()
        
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return signatureImage
    }
}
