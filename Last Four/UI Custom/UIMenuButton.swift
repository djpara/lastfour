//
//  UIMenuButton.swift
//  Split Check
//
//  Created by David Para on 4/14/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class UIMenuButton: UICustomButton {

    fileprivate var _bottomBar: CAShapeLayer!
    fileprivate var _topBar: CAShapeLayer!
    
    fileprivate var _ogBottomBarPath: CGPath!
    fileprivate var _ogTopBarPath: CGPath!
    
    fileprivate var _menuOpen = false
    fileprivate var _rendered = false
    
    override func draw(_ rect: CGRect) {
        if _rendered { return }
        
        _bottomBar = drawMenuLine(y: bounds.height/2 + 8)
        _topBar = drawMenuLine(y: bounds.height/2 - 8)
        
        _ogBottomBarPath = _bottomBar.path
        _ogTopBarPath = _topBar.path
        
        _rendered = true
    }
    
    fileprivate func drawMenuLine(y: CGFloat, toY: CGFloat = 0) -> CAShapeLayer {
        
        let path = createMenuBar(y: y)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = WHITE.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    fileprivate func createMenuX(fromY: CGFloat, toY: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 4, y: fromY))
        path.addLine(to: CGPoint(x: bounds.width-4, y: toY))
        path.lineJoinStyle = .round
        
        return path
    }
    
    fileprivate func createMenuBar(y: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 2, y: y))
        path.addLine(to: CGPoint(x: bounds.width-2, y: y))
        path.lineJoinStyle = .round
        
        return path
    }
    
    fileprivate func animatePathChange(for layer: CAShapeLayer, toPath: CGPath) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.25
        animation.fromValue = layer.path
        animation.toValue = toPath
        animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName("easeInEaseOut"))
        layer.add(animation, forKey: "path")
        layer.path = toPath
    }
    
    // MARK: Internal Functions
    internal func reset() {
        animatePathChange(for: _bottomBar, toPath: _ogBottomBarPath)
        animatePathChange(for: _topBar, toPath: _ogTopBarPath)
        
        _menuOpen = false
    }
    
    internal func closeIcon() {
        animatePathChange(for: _bottomBar, toPath: createMenuX(fromY: bounds.height/2 + 12, toY: bounds.height/2 - 12).cgPath)
        animatePathChange(for: _topBar, toPath: createMenuX(fromY: bounds.height/2 - 12, toY: bounds.height/2 + 12).cgPath)
        
        _menuOpen = true
    }

    /**
     Performs the action on tap
     */
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)

        if _menuOpen {
            reset()
        } else {
            closeIcon()
        }
        
    }
        
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
	return CAMediaTimingFunctionName(rawValue: input)
}
