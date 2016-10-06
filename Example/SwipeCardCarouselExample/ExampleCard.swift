//
//  ExampleCard.swift
//  SwipeCardCarouselExample
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit
import SwipeCardCarousel

class ExampleCard: SwipeCard {
	
	var titleLabel = UILabel()
	var aboutLabel = UILabel()
	var valueLabel = UILabel()
	
	var viewDictionary = [String: UIView]()
	
	private var viewLayoutComplete = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		layer.shadowOpacity = 0.15
		layer.shadowOffset = CGSize(width: 0, height: 0.9)
		layer.shadowRadius = 0.5
		titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
		viewDictionary["title"] = titleLabel
		aboutLabel.font = UIFont.italicSystemFont(ofSize: 16)
		viewDictionary["about"] = aboutLabel
		valueLabel.font = UIFont.systemFont(ofSize: 18)
		viewDictionary["value"] = valueLabel
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layoutAndAddSubviews() {
		if viewLayoutComplete { return }
		aboutLabel.numberOfLines = 5
		aboutLabel.lineBreakMode = .byWordWrapping
		for (key,view) in viewDictionary {
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
			let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[\(key)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary)
			addConstraints(h)
		}
		
		let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[title]-[about(>=75)]-[value]-8-|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: viewDictionary)
		addConstraints(constraints)
		viewLayoutComplete = true
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layoutAndAddSubviews()
	}
}

