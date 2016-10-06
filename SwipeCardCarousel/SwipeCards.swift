//
//  SwipeCards.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/5/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

public class SwipeCards: UIView, SwipeCardDelegate {
	
	var delegate: SwipeCardsViewDelegate?
	var cardInsets: CGFloat = 0
	fileprivate var curindex: Int = 0
	
	fileprivate var numcards: Int = 0
	fileprivate var cardrect: CGRect!
	fileprivate var deckready = false
	fileprivate var swipedirection: SwipeCardDirection = .none
	fileprivate var carddeck = [SwipeCard]()
	
	var topcard: SwipeCard? {
		get {
			return carddeck.first
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	fileprivate func setUpDeck() {
		deckready = true
		guard let delegate = delegate else { return }
		numcards = delegate.numberOfCardsInDeck()
		
		if numcards < 1 { return }
		
		let card = delegate.cardForIndex(index: curindex)
		cardrect = bounds.insetBy(dx: cardInsets, dy: cardInsets)
		card.delegate = self
		card.isontop = true
		card.frame = cardrect
		carddeck.append(card)
		addSubview(card)
		card.addIndicators(delegate.labelForNextIndicator(nextIndexValue(.next)),
		                   right: delegate.labelForNextIndicator(nextIndexValue(.prev)))
	}
	
	fileprivate func nextIndexValue(_ direction: SwipeCardDirection) -> Int {
		let next = curindex + direction.rawValue
		var newIndex = next
		
		if next > numcards - 1 {
			newIndex = 0
			return newIndex
		}
		
		if next < 0 {
			newIndex = numcards - 1
			return newIndex
		}
		
		return newIndex
	}
	
	fileprivate func nextIndex(_ direction: SwipeCardDirection) -> Int {
		curindex = nextIndexValue(direction)
		return curindex
	}
	
	public override func layoutSubviews() {
		if !deckready {
			setUpDeck()
		}
	}
	
	func setCurrentIndex(_ index: Int) {
		curindex = index
		guard let delegate = delegate else { return }
		guard let top = topcard else { return }
		top.updateIndicators(delegate.labelForNextIndicator(nextIndexValue(.next)), right: delegate.labelForNextIndicator(nextIndexValue(.prev)))
	}
	
	public func updateSwipe(distance: CGFloat) {
		let percentTraveled = distance / bounds.size.width
		let percentFromOriginState = (40 * percentTraveled) / 100
		let scale = 0.6 + percentFromOriginState
		if carddeck.count > 1 {
			let bottomcard = carddeck.last
			bottomcard?.alpha = scale
			bottomcard!.transform = CGAffineTransform.identity.scaledBy(x: scale	, y: scale)
		}
	}
	
	public func updateSwipe(direction: SwipeCardDirection) {
		guard let delegate = self.delegate else { return }
		if carddeck.count > 1 {
			if let btmcard = carddeck.last {
				btmcard.removeFromSuperview()
				carddeck.removeLast()
			}
		}
		self.swipedirection = direction
		let nextcard = delegate.cardForIndex(index: nextIndexValue(direction))
		nextcard.delegate = self
		nextcard.frame = bounds.insetBy(dx: cardInsets, dy: cardInsets)
		nextcard.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
		carddeck.append(nextcard)
		addSubview(nextcard)
		sendSubview(toBack: nextcard)
	}
	
	public func swipeComplete() {
		let topcard = carddeck.first
		let bottomcard = carddeck.last
		let xPos = (cardrect.size.width + 20) * CGFloat(swipedirection.rawValue)
		UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.55, options: UIViewAnimationOptions.curveEaseOut, animations: {
			topcard!.frame = CGRect(origin: CGPoint(x: xPos, y: self.cardrect.origin.y), size: self.cardrect.size)
			bottomcard!.transform = CGAffineTransform.identity
			bottomcard!.alpha = 1.0
			}, completion: { _ in
				self.curindex = self.nextIndexValue(self.swipedirection)
				topcard!.removeFromSuperview()
				self.carddeck.removeFirst()
				bottomcard!.isontop = true
				if let delegate = self.delegate {
					bottomcard!.addIndicators(delegate.labelForNextIndicator(self.nextIndexValue(.next)),
					                          right: delegate.labelForNextIndicator(self.nextIndexValue(.prev)))
				}
		})
	}
	
	func showNext() {
		self.updateSwipe(direction: .next)
		self.swipeComplete()
	}
	
	func showPrev() {
		self.updateSwipe(direction: .prev)
		self.swipeComplete()
	}
	
}

