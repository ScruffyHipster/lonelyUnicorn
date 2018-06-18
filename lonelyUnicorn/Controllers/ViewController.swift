//
//  ViewController.swift
//  lonelyUnicorn
//
//  Created by Tom Murray on 18/06/2018.
//  Copyright © 2018 Tom Murray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//properties
	var score: Int?
	var timer = Timer()
	var timeOnScreen = 1
	
	//Outlets
	@IBOutlet weak var robotButton: UIButton!
	@IBOutlet weak var alienButton: UIButton!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var startGameButton: UIButton!
	
	
	@IBAction func startButton(_ sender: Any) {
		startGame()
	}
	
	enum gameState {
		case started
		case gameOver
		case inPlay
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		gameSetup()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func gameSetup() {
		alienButton.isHidden = true
		robotButton.isHidden = true
		scoreLabel.text = ("\(score ?? 0)")
	}
	
	func startGame() {
		startGameButton.isHidden = true
		alienButton.isHidden = false
		
		let height = self.view.bounds.height
		let width = self.view.bounds.width
		
		
		let randomPoint = CGPoint(x: CGFloat(arc4random()).truncatingRemainder(dividingBy: height), y: CGFloat(arc4random()).truncatingRemainder(dividingBy: width))
		
		alienButton.center = randomPoint
		
	}

}

