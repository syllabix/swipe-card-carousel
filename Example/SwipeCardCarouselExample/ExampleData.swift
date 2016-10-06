//
//  ExampleData.swift
//  SwipeCardCarouselExample
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

struct ExampleData {
	var name: String?
	var description: String
	var value: Double
	
	init(name: String?, description: String, value: Double) {
		self.name = name
		self.description = description
		self.value = value
	}
}

func getExampleData() -> [ExampleData] {
	return [ExampleData(name: "Rare Shoe", description: "This rare shoe will make your feet look incredible.", value: 134.43),ExampleData(name: "Potted Plant", description: "Liven up any space in your home, apartment, or igloo with this potted plant. It is an amazing plant, and it liven's up things well. Guests will appreciate it.", value: 23.43),
	        ExampleData(name: "Fun Toy", description: "Do you or your children exhibit signs of not having enough fun? Well, look no further - this fun toy is so fun you will not exhibit those signs until the next version.", value: 823.23)]
}
