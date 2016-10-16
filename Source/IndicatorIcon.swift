//
//  IndicatorIcon.swift
//  Icons
//
//  Created by Tom Stoepker on 10/15/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

public enum IndicatorDirection {
	case Left, Right
}

open class IndicatorIcon: UIView {

	var color: UIColor?
	var direction: IndicatorDirection?
	var lineWidth: CGFloat = 2.0
	var lineCap = kCALineCapButt
	
	internal var iconColor: CGColor {
		get {
			guard let c = self.color else {
				return UIColor.white.cgColor
			}
			return c.cgColor
		}
	}
	
	internal var iconDirection: IndicatorDirection {
		get {
			guard let dir = self.direction else {
				return .Right
			}
			return dir
		}
	}
	
	internal func remove(layer: CAShapeLayer?) {
		if let l = layer {
			l.removeFromSuperlayer()
		}
	}
	
	internal func addLayer(start: CGPoint, end: CGPoint) -> CAShapeLayer {
		let iconLayer = CAShapeLayer()
		let path = UIBezierPath()
		path.move(to: start)
		path.addLine(to: end)
		iconLayer.lineCap = self.lineCap
		iconLayer.path = path.cgPath
		iconLayer.strokeColor = iconColor
		iconLayer.lineWidth = lineWidth
		iconLayer.fillColor = nil
		self.layer.addSublayer(iconLayer)
		return iconLayer
	}
	
	internal func addLayerWith(path: UIBezierPath) -> CAShapeLayer {
		let iconLayer = CAShapeLayer()
		iconLayer.lineCap = self.lineCap
		iconLayer.path = path.cgPath
		iconLayer.strokeColor = iconColor
		iconLayer.lineWidth = lineWidth
		iconLayer.fillColor = nil
		self.layer.addSublayer(iconLayer)
		return iconLayer
	}

}
