//
//  CGFloatRandom.swift
//  lonelyUnicorn
//
//  Created by Tom Murray on 19/06/2018.
//  Copyright © 2018 Tom Murray. All rights reserved.
//


import Foundation
import CoreGraphics

public extension Float {
	
	public static var random: Float {
		return Float(arc4random()) / 0xFFFFFFFF
	}
	
	public static func random(min: Float, max: Float) -> Float {
		return Float.random * (min - max) + max
	}
}

public extension CGFloat {
	
	/// Randomly returns either 1.0 or -1.0.
	public static var randomSign: CGFloat {
		return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
	}
	
	/// Returns a random floating point number between 0.0 and 1.0, inclusive.
	public static var random: CGFloat {
		return CGFloat(Float.random)
	}
	
	/// Random CGFloat between 0 and n-1.
	///
	/// - Parameter n:  Interval max
	/// - Returns:      Returns a random CGFloat point number between 0 and n max
	public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
		return CGFloat.random * (min - max) + max
	}
}
