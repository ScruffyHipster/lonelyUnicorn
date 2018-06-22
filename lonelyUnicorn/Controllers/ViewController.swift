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
	var score: Int!
	var timer: Timer!
	var buttons = [UIButton]()
	var currentButton: UIButton!
	var state: State!
	var gamePoints: Int!
	var randomIndex: Int!
	
	//Outlets
	@IBOutlet weak var robotButton: UIButton!
	@IBOutlet weak var alienButton: UIButton!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var startGameButton: UIButton!
	
	
	@IBAction func startButton(_ sender: Any) {
		startNewGame()
	}
	
	@IBAction func alienButtonTapped(_ sender: Any) {
		print("tapped alien")
		gamePoints = gamePoints + 1
		alienButton.isHidden = true
		timer.invalidate()
		oneGameRound()
	}
	
	@IBAction func robotButtonTapped(_ sender: Any) {
		print("tapped robot")
		robotButton.isHidden = true
		timer.invalidate()
	}
	
	enum State {
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
		buttons = [alienButton, robotButton]
		for button in buttons {
			button.isHidden = true
		}
		scoreLabel.isHidden  = true
		currentButton = alienButton
		state = State.gameOver
	}
	
	func startNewGame() {
		startGameButton.isHidden = true
		scoreLabel.isHidden = false
		gamePoints = 0
		updatePointsLabel(gamePoints)
		state = State.inPlay
		oneGameRound()
	}
	
	func oneGameRound() {
		updatePointsLabel(gamePoints)
		displayRandomButton()
		timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in
			if self.state == State.inPlay {
				if self.currentButton == self.alienButton {
					print("game over")
				} else {
					self.oneGameRound()
				}
			}
		})
	}
	
	func displayRandomButton() {
		
		randomIndex = Int(arc4random_uniform(UInt32(buttons.count)))
		
		let viewWidth = view.bounds.width
		let viewHeight = view.bounds.height
		
		let buttonWidth = currentButton.bounds.width
		let buttonHeight = currentButton.bounds.height
		
		let xWidth = viewWidth - buttonWidth
		let yHeight = viewHeight - buttonHeight
		
		let xOffset = CGFloat(arc4random_uniform(UInt32(xWidth)))
		let yOffset = CGFloat(arc4random_uniform(UInt32(yHeight)))
		
		if randomIndex == alienButton.tag {
			currentButton = alienButton
			alienButton.isHidden = false
			robotButton.isHidden = true
		}
		else if randomIndex == robotButton.tag {
			currentButton = robotButton
			alienButton.isHidden = true
			robotButton.isHidden = false
		}
		currentButton.center.x = xOffset + buttonWidth / 2
		currentButton.center.y = yOffset + buttonHeight / 2
	}
	
	func updatePointsLabel(_ newValue: Int) {
		scoreLabel.text = "\(newValue)"
	}

}

