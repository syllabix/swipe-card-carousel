//
//  SwipeIndicator.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit


public class SwipeIndicator: UIView {
	
	private var contextLabel = UILabel()
	private var directionLabel = CAShapeLayer()
	private let circle = CAShapeLayer()
	private let iconType = IndicatorIconType.chevron
	
	var text: String? {
		didSet {
			textToLabel()
		}
	}
	
	//Context label (label that appears under the indcator that should give context for the next view being swiped too
	var textColor = UIColor.black
	var font = UIFont.systemFont(ofSize: 18)
	
	var direction: SwipeCardDirection?
	
	//Background color of the indicator at the beginning of the swipe
	var startcolor = UIColor.gray.cgColor
	
	//Background color of the indicator once swipe distance is enough to consider it a full swipe
	var endcolor = UIColor.blue.cgColor
	
	private var complete = false
	
	override public func layoutSubviews() {
		let diameter: CGFloat = bounds.height / 2
		let xPos: CGFloat = (bounds.width / 2) - (diameter / 2)
		let circlerect = CGRect(x: xPos, y: 0, width: diameter, height: diameter)
		circle.path = UIBezierPath(ovalIn: circlerect).cgPath
		circle.fillColor = startcolor
		
		let iconWidth = diameter / 4
		let iconHeight = diameter / 6
		let icon = iconType.icon
		icon.direction = (self.direction == SwipeCardDirection.prev) ? IndicatorDirection.Left : IndicatorDirection.Right
		icon.lineWidth = 7
		let offsetX: CGFloat = (self.direction == SwipeCardDirection.prev) ? -3.5 : 3.5;
		let icoFrame = circlerect.insetBy(dx: iconWidth, dy: iconHeight)
		icon.frame = icoFrame.offsetBy(dx: offsetX, dy: 0)
		
		let adjustment = CGFloat((direction?.rawValue)!)
		directionLabel.frame = CGRect(origin: CGPoint(x: circlerect.origin.x + adjustment, y: circlerect.origin.y), size: circlerect.size)
		contextLabel.font = font
		contextLabel.textColor = textColor
		contextLabel.textAlignment = .center
		contextLabel.frame = CGRect(x: 0, y: diameter, width: bounds.width, height: bounds.height / 2)
		contextLabel.text = text
		
		layer.addSublayer(circle)
		circle.addSublayer(directionLabel)
		addSubview(contextLabel)
		addSubview(icon)
	}
	
	func isSwipe(complete: Bool) {
		if complete != self.complete {
			self.complete = complete
			let coloranim = CABasicAnimation(keyPath: "fillColor")
			coloranim.fromValue = complete ? startcolor : endcolor
			coloranim.toValue = complete ? endcolor : startcolor
			coloranim.duration = 0.2
			coloranim.fillMode = kCAFillModeForwards
			circle.add(coloranim, forKey: nil)
			circle.fillColor = complete ? endcolor : startcolor
		}
	}
	
	private func textToLabel() {
		guard let text = self.text else { return }
		contextLabel.text = text
	}
	
	func dismiss() {
		UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 0.0
			self.frame.origin.x = self.direction == .next ? 0 : self.superview!.bounds.size.width - self.bounds.size.width
		}) { _ in
			self.isHidden = true
		}
	}
}

