public protocol TabDescription {
	func tabDescription(max:Int) -> String
}
public extension TabDescription where Self:CustomStringConvertible {
	func tabDescription(max:Int) -> String {
		let MaxtabCount = (max / 4) + 1
		let count = description.count
		let myTabCount = MaxtabCount - (count / 4)
		var resultString = description
		for _ in 0..<myTabCount {
			resultString += "\t"
		}
		return resultString
	}
}

extension String: TabDescription { }
