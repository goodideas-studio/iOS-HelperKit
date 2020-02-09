//
//  Optional+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/1.
//  Copyright © 2019 ytyubox. All rights reserved.
//
public
extension Optional where Wrapped == Void {
	/** Only apply Void?
	
	```swift
	let clousure: (()->Void)? = nil
	func get() {
	return clousure?().unwrapped
	}
	```
	*/
	var unwrapped: Wrapped {return}
}

public extension Optional {
	var notNil: Bool {switch self {
	case .some: return true
	case .none: return false
		}
	}
}
