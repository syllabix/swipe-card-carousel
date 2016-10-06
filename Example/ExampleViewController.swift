//
//  ExampleViewController.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/6/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
	
	@IBOutlet weak var cardDeck: SwipeCardDeck!
	
	var data = [ExampleData]()

    override func viewDidLoad() {
        super.viewDidLoad()
		data = getExampleData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ExampleViewController: SwipeCardDeckDelegate {
	
	func cardAt(index: Int) -> SwipeCard {
		let d = data[index]
		let card = ExampleCard()
		card.titleLabel.text = d.name
		card.aboutLabel.text = d.description
		card.valueLabel.text = "Price: $\(d.value)"
		return card
	}
	
	func numberOfCardsInDeck() -> Int {
		return data.count
	}
	
	func labelForNextIndicatorAt(index: Int) -> String {
		guard let text = data[index].name else {
			return "Next"
		}
		return text
	}
	
	func labelForPrevIndicatorAt(index: Int) -> String {
		guard let text = data[index].name else {
			return "Prev"
		}
		return text
	}
}
