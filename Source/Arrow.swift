//
//  Arrow.swift
//  Icons
//
//  Created by Tom Stoepker on 10/15/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

public class Arrow: IndicatorIcon {
	
	private var stem: CAShapeLayer?
	private var arrow: CAShapeLayer?
	
	private func drawArrow() {
		remove(layer: stem)
		remove(layer: arrow)
		
		let stemY = bounds.size.height / 2
		let stemXStart = (direction == .Left) ? lineWidth : bounds.size.width - lineWidth
		let stemXEnd = (direction == .Left) ? bounds.size.width - lineWidth: lineWidth
		let stemStartPoint = CGPoint(x: stemXStart, y: stemY)
		let stemEndPoint = CGPoint(x: stemXEnd, y: stemY)
		stem = addLayer(start: stemStartPoint, end: stemEndPoint)
		
		let arrowStartY = bounds.size.height / 4
		let arrowStartX = bounds.size.width / 2
		let arrowStart = CGPoint(x: arrowStartX, y: arrowStartY)
		
		let arrowTipX = (direction == .Left) ? lineWidth : bounds.size.width - lineWidth
		
		let arrowEndY = (bounds.size.height / 2) + (bounds.size.height / 4)
		let arrowEndX = bounds.size.width / 2
		
		let arrowPath = UIBezierPath()
		arrowPath.move(to: arrowStart)
		arrowPath.addLine(to: CGPoint(x: arrowTipX, y: stemY))
		arrowPath.addLine(to: CGPoint(x: arrowEndX, y: arrowEndY))
		arrow = addLayerWith(path: arrowPath)
		
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
		drawArrow()
	}

}
