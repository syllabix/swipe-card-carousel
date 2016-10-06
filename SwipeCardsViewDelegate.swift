//
//  SwipeCardsViewDelegate.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/5/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

public protocol SwipeCardsViewDelegate {
	func cardForIndex(index: Int) -> SwipeCard
	func numberOfCardsInDeck() -> Int
	func labelForNextIndicator(_ index: Int) -> String
	func labelForPrevIndicator(_ index: Int) -> String
}

