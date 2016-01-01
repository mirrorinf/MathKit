//
//  Complex.swift
//  MathKit
//
//  Created by 褚晓敏 on 12/26/15.
//  Copyright © 2015 Levity. All rights reserved.
//

import Foundation

class MKNComplex {
	var real, imaginary: CGFloat
	
	init(real: CGFloat, imaginary: CGFloat) {
		self.real = real
		self.imaginary = imaginary
	}
	
	init(real: CGFloat) {
		self.real = real
		self.imaginary = 0.0
	}
	
	init(real: Int) {
		self.real = CGFloat(real)
		self.imaginary = 0.0
	}
	
	init(imaginary: CGFloat) {
		self.real = 0.0
		self.imaginary = imaginary
	}
	
	init(imaginary: Int) {
		self.real = 0.0
		self.imaginary = CGFloat(imaginary)
	}
	
	init(radius: CGFloat, angle: CGFloat) {
		self.real = radius * cos(angle)
		self.imaginary = radius * sin(angle)
	}
	
	var norm: CGFloat {
		let x = self.real * self.real
		return x + self.imaginary * self.imaginary
	}
}

func +(lhs: MKNComplex, rhs: MKNComplex) -> MKNComplex {
	return MKNComplex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
}

func -(lhs: MKNComplex, rhs: MKNComplex) -> MKNComplex {
	return MKNComplex(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
}

func *(lhs: CGFloat, rhs: MKNComplex) -> MKNComplex {
	return MKNComplex(real: lhs * rhs.real, imaginary: lhs * rhs.imaginary)
}

func *(lhs: MKNComplex, rhs: CGFloat) -> MKNComplex {
	return MKNComplex(real: lhs.real * rhs, imaginary: lhs.imaginary * rhs)
}

func *(lhs: MKNComplex, rhs: MKNComplex) -> MKNComplex {
	let real = lhs.real * rhs.real - lhs.imaginary * rhs.imaginary
	let imaginary = lhs.imaginary * rhs.real + lhs.real * rhs.imaginary
	return MKNComplex(real: real, imaginary: imaginary)
}

func /(lhs: MKNComplex, rhs: CGFloat) -> MKNComplex {
	return MKNComplex(real: lhs.real / rhs, imaginary: lhs.imaginary / rhs)
}