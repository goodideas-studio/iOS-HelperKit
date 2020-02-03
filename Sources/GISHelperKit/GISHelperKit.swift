public extension Array {
	func sum<T>(by keyPath: KeyPath<Element,T>) -> T where T: Numeric {
		reduce(into: 0) { (result, e) in
			result += e[keyPath: keyPath]
		}
	}
}

