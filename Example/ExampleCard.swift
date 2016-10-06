//
//  ExampleCard.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

class ExampleCard: SwipeCard {
	
	var titleLabel = UILabel()
	var aboutLabel = UILabel()
	var valueLabel = UILabel()
	
	var viewDictionary = [String: UIView]()
	
	private var viewLayoutComplete = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)
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
		
		let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[title]-[about]-value-8-|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: viewDictionary)
		addConstraints(constraints)
		
		for (_,view) in viewDictionary {
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layoutAndAddSubviews()
	}
}
