//
//  Chevron.swift
//  Icons
//
//  Created by Tom Stoepker on 10/15/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

class Chevron: IndicatorIcon {	
	
	private var chevron: CAShapeLayer?
	
	private func drawChevron() {
		remove(layer: chevron)
		
		let startX = (direction == .Left) ? lineWidth : bounds.size.width - lineWidth
		let startY = bounds.size.height / 2
		let startPoint = CGPoint(x: startX, y: startY)
		
		let endX = (direction == .Left) ? bounds.size.width - (lineWidth / 2) : lineWidth / 2
		let topEndY = lineWidth / 2
		let topEndPoint = CGPoint(x: endX, y: topEndY)
		
		let bottomEndPoint = CGPoint(x: endX, y: bounds.size.height - (lineWidth / 2))
		
		let path = UIBezierPath()
		path.move(to: topEndPoint)
		path.addLine(to: startPoint)
		path.addLine(to: bottomEndPoint)
		chevron = addLayerWith(path: path)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		drawChevron()
	}
	

}
