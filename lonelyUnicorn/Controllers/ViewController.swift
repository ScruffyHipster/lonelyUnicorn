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
		scoreLabel.isHidden = true
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
					//self.gameOver
				} else {
					self.oneGameRound()
				}
			}
		})
	}
	
	func displayRandomButton() {
		randomIndex = Int(arc4random_uniform(UInt32(buttons.count)))
		
		if randomIndex == alienButton.tag {
			alienButton.isHidden = false
			robotButton.isHidden = true
		}
		else if randomIndex == robotButton.tag {
			alienButton.isHidden = true
			robotButton.isHidden = false
		}
	}
	
	func updatePointsLabel(_ newValue: Int) {
		scoreLabel.text = "\(newValue)"
	}
	
	func randCGFloat(_ min: CGFloat, _ max: CGFloat ) -> CGFloat {
		return CGFloat.random(min: 2.0, max:4.0)
	}

	func randomXcoordinate() -> CGFloat {
		let left = view.safeAreaInsets.left + currentButton.bounds.width
		let right = view.safeAreaInsets.right + currentButton.bounds.width
		return randCGFloat(left, right)
	}
	
	func randomYcoordinate() -> CGFloat {
		let top = view.safeAreaInsets.top + currentButton.bounds.height
		let bottom = view.safeAreaInsets.bottom + currentButton.bounds.height
		return randCGFloat(top, bottom)
	}
}

