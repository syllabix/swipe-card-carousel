//
//  SwipeIndicator.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/5/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

public class SwipeIndicator: UIView {
	
	fileprivate var contextLabel = UILabel()
	fileprivate var directionLabel = Icon()
	fileprivate let circle = CAShapeLayer()
	
	var text: String? {
		didSet {
			mapTextToLabel()
		}
	}
	var direction: SwipeCardDirection?
	var startcolor = UIColor.lightGray.cgColor
	var endcolor = UIColor.blue.cgColor
	
	fileprivate var complete = false
	
	override public func layoutSubviews() {
		let diameter: CGFloat = bounds.height / 2
		let xPos: CGFloat = (bounds.width / 2) - (diameter / 2)
		let circlerect = CGRect(x: xPos, y: 0, width: diameter, height: diameter)
		circle.path = UIBezierPath(ovalIn: circlerect).cgPath
		circle.fillColor = startcolor
		
		if let direction = self.direction {
			directionLabel = direction == .prev ? LeftArrowIcon() : RightArrowIcon()
		}
		
		let adjustment = CGFloat((self.direction?.rawValue)!)
		directionLabel.frame = CGRect(origin: CGPoint(x: circlerect.origin.x + adjustment, y: circlerect.origin.y), size: circlerect.size)
		directionLabel.iconSize = diameter / 2
		directionLabel.textColor = UIColor(named: AppColor.white)
		directionLabel.textAlignment = .center
		contextLabel.font = UIFont(appfont: AppFont.DemiBold, size: 24)
		contextLabel.textColor = UIColor(named: AppColor.black)
		contextLabel.textAlignment = .center
		contextLabel.frame = CGRect(x: 0, y: diameter, width: bounds.width, height: bounds.height / 2)
		contextLabel.text = self.text
		
		layer.addSublayer(circle)
		addSubview(directionLabel)
		addSubview(contextLabel)
	}
	
	func setCompleteState(_ done: Bool) {
		if done != self.complete {
			self.complete = done
			let coloranim = CABasicAnimation(keyPath: "fillColor")
			coloranim.fromValue = complete ? startcolor : endcolor
			coloranim.toValue = complete ? endcolor : startcolor
			coloranim.duration = 0.2
			coloranim.fillMode = kCAFillModeForwards
			circle.add(coloranim, forKey: nil)
			circle.fillColor = complete ? endcolor : startcolor
		}
	}
	
	fileprivate func mapTextToLabel() {
		Mapper.toLabel(label: contextLabel, val: text as AnyObject?)
	}
	
	func dismiss() {
		UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 0.0
			self.frame.origin.x = self.direction == .next ? 0 : self.superview!.bounds.size.width - self.bounds.size.width
		}) { _ in
			self.isHidden = true
		}
	}
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/
	
}
