//
//  UIImage+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/12/20.
//  Copyright © 2019 ytyubox. All rights reserved.
//
#if canImport(UIKit)

import UIKit
public
extension UIImage {
	func maskWithColors(color: UIColor) -> UIImage? {
		let maskingColors: [CGFloat] = [100, 255, 100, 255, 100, 255] // We should replace white color.
		let maskImage = cgImage! //
		let bounds = CGRect(x: 0, y: 0, width: size.width * 3, height: size.height * 3) // * 3, for best resolution.
		let sz = CGSize(width: size.width * 3, height: size.height * 3) // Size.
		var returnImage: UIImage? // Image, to return

		/* Firstly we will remove transparent background, because
		maskingColorComponents don't work with transparent images. */

		UIGraphicsBeginImageContextWithOptions(sz, true, 0.0)
		let context = UIGraphicsGetCurrentContext()!
		context.saveGState()
		context.scaleBy(x: 1.0, y: -1.0) // iOS flips images upside down, this fix it.
		context.translateBy(x: 0, y: -sz.height) // and this :)
		context.draw(maskImage, in: bounds)
		context.restoreGState()
		let noAlphaImage = UIGraphicsGetImageFromCurrentImageContext() // new image, without transparent elements.
		UIGraphicsEndImageContext()

		let noAlphaCGRef = noAlphaImage?.cgImage // get CGImage.

		if let imgRefCopy = noAlphaCGRef?.copy(maskingColorComponents: maskingColors) { // Magic.
			UIGraphicsBeginImageContextWithOptions(sz, false, 0.0)
			let context = UIGraphicsGetCurrentContext()!
			context.scaleBy(x: 1.0, y: -1.0)
			context.translateBy(x: 0, y: -sz.height)
			context.clip(to: bounds, mask: maskImage) // Remove background from image with mask.
			context.setFillColor(color.cgColor) // set new color. We remove white color, and set red.
			context.fill(bounds)
			context.draw(imgRefCopy, in: bounds) // draw new image
			let finalImage = UIGraphicsGetImageFromCurrentImageContext()
			returnImage = finalImage! // YEAH!
			UIGraphicsEndImageContext()
		}
		return returnImage
	}
	/// Repleac 
	/// - Parameter color: after color
	/// - Resource: https://stackoverflow.com/questions/34388159/how-to-colorize-transparent-holes-in-uiimage
	func transperentImage(color: UIColor = .white) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		let imageRect: CGRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
		let ctx: CGContext = UIGraphicsGetCurrentContext()!
		// Draw a white background (for white mask)
		ctx.setFillColor(color.cgColor)
		ctx.fill(imageRect)
		// Apply the source image's alpha
		self.draw(in: imageRect, blendMode: .normal, alpha: 1.0)
		let mask: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return mask
	}

}

#endif
