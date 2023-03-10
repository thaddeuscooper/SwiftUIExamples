//
//  BearingAndDistance.swift
//  ADIF Viewer
//
//  Created by Thaddeus Cooper on 1/3/23.
//

import SwiftUI

// ZStack (https://developer.apple.com/documentation/swiftui/zstack)
// Circle (https://developer.apple.com/documentation/swiftui/circle)
// Text (https://developer.apple.com/documentation/swiftui/text)
// Measurement (https://developer.apple.com/documentation/foundation/measurement)
// Double (https://developer.apple.com/documentation/swift/double/)

// This view implements a display to show bearing and distance, where bearing is in degrees and distance is in miles. It uses Measurement to store the values.
struct BearingAndDistance: View {
	var bearing = Measurement(value: 0.0, unit: UnitAngle.degrees)
	var distance = Measurement(value: 0.0, unit: UnitLength.miles)
	
	var body: some View {
		let frameWidth = 75.0
		let frameHeight = 75.0
		let frameDistance = frameWidth / 2.0
		let offsetRotation = 90.0 * (Double.pi / 180.0)
		let multiplier = Double.pi / 180.0
		
		let offsetX = cos((bearing.value * multiplier) - offsetRotation) * frameDistance
		let offsetY = sin((bearing.value * multiplier) - offsetRotation) * frameDistance
		
		ZStack {
			Circle()
				.stroke(.green, lineWidth: 8.0)
				.frame(width: frameWidth, height: frameHeight)
				.padding(5)
				.shadow(radius: 3.0)
			Circle()
				.fill(.white)
				.frame(width: 6.0, height: 6.0)
				.offset(x: offsetX, y: offsetY)
			Text("\(distance.value.formatted(.number)) \(distance.unit.symbol)")
				.font(.system(size: 10.0))
		}
		
	}
}

struct BearingAndDistance_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			BearingAndDistance()
			BearingAndDistance(bearing: Measurement(value: 45.0, unit: UnitAngle.degrees))
			BearingAndDistance(bearing: Measurement(value: 360.0, unit: UnitAngle.degrees))
			BearingAndDistance(bearing: Measurement(value: 90.0, unit: UnitAngle.degrees),
							   distance: Measurement(value: 10.0, unit: UnitLength.kilometers))
			BearingAndDistance(bearing: Measurement(value: 90.0, unit: UnitAngle.degrees),
							   distance: Measurement(value: 50.0, unit: UnitLength.miles))
		}
	}
}
