//
//  SwipeCardDelegate.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

public protocol SwipeCardDelegate {
	func updateSwipe(direction: SwipeCardDirection)
	func updateSwipe(distance: CGFloat)
	func swipeComplete()
}
