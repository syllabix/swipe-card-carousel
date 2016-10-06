//
//  SwipeCardsViewDelegate.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

public protocol SwipeCardDeckDelegate {
	func cardAt(index: Int) -> SwipeCard
	func numberOfCardsInDeck() -> Int
	func labelForNextIndicatorAt(index: Int) -> String
	func labelForPrevIndicatorAt(index: Int) -> String
}
