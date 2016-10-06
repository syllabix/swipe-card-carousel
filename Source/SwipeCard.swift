//
//  SwipeCard.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

open class SwipeCard: UIView, UIGestureRecognizerDelegate {
	
	var originalCenter = CGPoint()
	var delegate: SwipeCardDelegate?
	var isontop = false
	
	private var swipecomplete = false
	private var direction: SwipeCardDirection = .none
	
	private let nxt = SwipeIndicator()
	private let prev = SwipeIndicator()
	
	var indicatorSize: CGFloat {
		get {
			return direction == .next ? nxt.bounds.size.width : prev.bounds.size.width
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let panrecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeCard.handlePan(_:)))
		panrecognizer.delegate = self
		addGestureRecognizer(panrecognizer)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func handlePan(_ recognizer: UIPanGestureRecognizer) {
		if !isontop { return }
		
		if recognizer.state == .began {
			originalCenter = center
		}
		
		if recognizer.state == .changed {
			let translation = recognizer.translation(in: self)
			let newCenter = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
			let distance = abs(translation.x)
			let scale = distance / bounds.size.width
			delegate?.updateSwipe(distance: distance)
			let newdirection: SwipeCardDirection = (newCenter.x < originalCenter.x) ? .prev : .next
			swipecomplete = (frame.origin.x < (-frame.size.width * 0.45)) || (frame.origin.x > (frame.size.width * 0.45))
			prev.isSwipe(complete: swipecomplete)
			nxt.isSwipe(complete: swipecomplete)
			if swipecomplete {
				UIView.animate(withDuration: 0.2, animations: {
					self.nxt.alpha = 1.0
					self.prev.alpha = 1.0
				})
			} else {
				let nudge: CGFloat = 0.2
				nxt.transform = CGAffineTransform.identity.scaledBy(x: scale + nudge, y: scale + nudge)
				prev.transform = CGAffineTransform.identity.scaledBy(x: scale + nudge, y: scale + nudge)
				nxt.alpha = scale
				prev.alpha = scale
			}
			if newdirection != self.direction {
				self.direction = newdirection
				delegate?.updateSwipe(direction: direction)
			}
			center = newCenter
		}
		
		if recognizer.state == .ended {
			if swipecomplete {
				prev.dismiss()
				nxt.dismiss()
				delegate?.swipeComplete()
			} else {
				let orginalFrame = CGRect(x: 0, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
				UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseOut, animations: {
					self.frame = orginalFrame
					}, completion: { (_) in
						// TODO: discern what might be useful here
				})
			}
			
		}
	}
	
	func updateIndicators(_ left: String, right: String) {
		prev.text = right
		nxt.text = left
	}
	
	func addIndicators(_ left: String, right: String) {
		let yAndHeight = bounds.size.height / 3
		let width: CGFloat = bounds.size.width / 3
		
		nxt.direction = .next
		nxt.text = left
		let nextorigin = CGPoint(x: -width, y: yAndHeight)
		let nextsize = CGSize(width: width, height: yAndHeight)
		nxt.frame = CGRect(origin: nextorigin, size: nextsize)
		nxt.alpha = 0.0
		
		prev.direction = .prev
		prev.text = right
		let prevorigin = CGPoint(x: bounds.size.width, y: yAndHeight)
		let prevsize = CGSize(width: width, height: yAndHeight)
		prev.frame = CGRect(origin: prevorigin, size: prevsize)
		prev.alpha = 0.0
		
		addSubview(nxt)
		addSubview(prev)
	}
	
	override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
			let translation = panGestureRecognizer.translation(in: superview!)
			if fabs(translation.x) > fabs(translation.y) {
				return true
			}
			return false
		}
		return false
	}
	
}




