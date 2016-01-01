//
//  SymmetricPolynomialOver3Variables.swift
//  MathKit
//
//  Created by 褚晓敏 on 12/27/15.
//  Copyright © 2015 Levity. All rights reserved.
//

import Foundation

func power(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
	return pow(lhs, rhs)
}

class MKSSymmetricTerm {
	var exponent: [CGFloat]
	let permutation = [[0, 1, 2], [0, 2, 1], [1, 2, 0], [1, 0, 2], [2, 0, 1], [2, 1, 0]]
	
	init(exponent: [CGFloat]) {
		switch exponent.count {
		case 1:
			self.exponent = [exponent[0], 0, 0]
		case 2:
			self.exponent = [exponent[0], exponent[1], 0]
		default:
			self.exponent = [exponent[0], exponent[1], exponent[2]]
		}
		self.exponent.sortInPlace{$0 > $1}
	}
	
	init(e1: CGFloat, e2: CGFloat, e3: CGFloat) {
		self.exponent = [e1, e2, e3]
		self.exponent.sortInPlace{$0 > $1}
	}
	
	init(e1: Int, e2: Int, e3: Int) {
		self.exponent = [CGFloat(e1), CGFloat(e2), CGFloat(e3)]
		self.exponent.sortInPlace{$0 > $1}
	}
	
	func evaluation(x: CGFloat, y: CGFloat, z: CGFloat) -> CGFloat {
		var ans: CGFloat = 0.0
		for p in permutation {
			ans += power(x, rhs: exponent[p[0]]) * power(y, rhs: exponent[p[1]]) * power(z, rhs: exponent[p[2]])
		}
		return ans
	}
	
	var describe: String {
		var str: String = ""
		str += "["
		str += "\(exponent[0]), "
		str += "\(exponent[1]), "
		str += "\(exponent[2])]"
		return str
	}
}

func ==(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> Bool {
	return lhs.exponent == rhs.exponent
}

func >=(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> Bool {
	let state1 = lhs.exponent[0] >= rhs.exponent[0]
	let state2 = lhs.exponent[0] + lhs.exponent[1] >= rhs.exponent[0] + rhs.exponent[1]
	let state3 = lhs.exponent[0] + lhs.exponent[1] + lhs.exponent[2] >= rhs.exponent[0] + rhs.exponent[1] + rhs.exponent[2]
	return state1 && state2 && state3
}

func >(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> Bool {
	let state1 = lhs.exponent[0] > rhs.exponent[0]
	let state2 = lhs.exponent[0] + lhs.exponent[1] > rhs.exponent[0] + rhs.exponent[1]
	let state3 = lhs.exponent[0] + lhs.exponent[1] + lhs.exponent[2] >= rhs.exponent[0] + rhs.exponent[1] + rhs.exponent[2]
	return state1 && state2 && state3
}

func <=(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> Bool {
	return rhs >= lhs
}

func <(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> Bool {
	return rhs > lhs
}

class MKSSymmetricPolynomial {
	var terms: [(CGFloat, MKSSymmetricTerm)]
	
	init() {
		self.terms = []
	}
	
	func addTerm(coeffient: CGFloat, term: MKSSymmetricTerm) {
		for i in 0..<self.terms.count {
			if self.terms[i].1 == term {
				self.terms[i].0 += coeffient
				if terms[i].0 == 0 {
					terms.removeAtIndex(i)
				}
				return
			}
		}
		self.terms.append((coeffient, term))
	}
	
	var describe: String {
		var answer: String = ""
		for term in terms {
			answer += " \(term.0) \(term.1.describe)"
		}
		return answer
	}
	
	func evaluation(x: CGFloat, y: CGFloat, z: CGFloat) -> CGFloat {
		var ans: CGFloat = 0.0
		for term in self.terms {
			ans += term.0 * term.1.evaluation(x, y: y, z: z)
		}
		return ans
	}
}

func +(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	for term in lhs.terms {
		answer.addTerm(term.0, term: term.1)
	}
	for term in rhs.terms {
		answer.addTerm(term.0, term: term.1)
	}
	return answer
}

func -(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	for term in lhs.terms {
		answer.addTerm(term.0, term: term.1)
	}
	for term in rhs.terms {
		answer.addTerm(-term.0, term: term.1)
	}
	return answer
}

func +(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	answer.addTerm(1.0, term: lhs)
	answer.addTerm(1.0, term: rhs)
	return answer
}

func -(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	answer.addTerm(1.0, term: lhs)
	answer.addTerm(-1.0, term: rhs)
	return answer
}

func +(lhs: MKSSymmetricTerm, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	let ans = MKSSymmetricPolynomial()
	for term in rhs.terms {
		ans.addTerm(term.0, term: term.1)
	}
	ans.addTerm(1.0, term: lhs)
	return ans
}

func -(lhs: MKSSymmetricTerm, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	let ans = MKSSymmetricPolynomial()
	for term in rhs.terms {
		ans.addTerm(-term.0, term: term.1)
	}
	ans.addTerm(1.0, term: lhs)
	return ans
}

func +(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	return rhs + lhs
}

func -(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	let ans = MKSSymmetricPolynomial()
	for term in lhs.terms {
		ans.addTerm(term.0, term: term.1)
	}
	ans.addTerm(-1.0, term: rhs)
	return ans
}

func *(lhs: MKSSymmetricTerm, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	for work in rhs.permutation {
		var expo: [CGFloat] = []
		for i in 0..<3 {
			let newPiece = lhs.exponent[i] + rhs.exponent[work[i]]
			expo.append(newPiece)
		}
		answer.addTerm(1.0, term: MKSSymmetricTerm(exponent: expo))
	}
	return answer
}

func *(lhs: CGFloat, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	let answer = MKSSymmetricPolynomial()
	for term in rhs.terms {
		answer.addTerm(term.0 * lhs, term: term.1)
	}
	return answer
}

func *(lhs: MKSSymmetricPolynomial, rhs: CGFloat) -> MKSSymmetricPolynomial {
	return rhs * lhs
}

func *(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricTerm) -> MKSSymmetricPolynomial {
	var answer = MKSSymmetricPolynomial()
	for term in lhs.terms {
		answer = answer + term.0 * (lhs * term.1)
	}
	return answer
}

func *(lhs: MKSSymmetricTerm, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	return rhs * lhs
}

func *(lhs: MKSSymmetricPolynomial, rhs: MKSSymmetricPolynomial) -> MKSSymmetricPolynomial {
	var answer = MKSSymmetricPolynomial()
	for term in rhs.terms {
		answer = answer + term.0 * (term.1 * lhs)
	}
	return answer
}