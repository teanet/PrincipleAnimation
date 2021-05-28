import UIKit

public class Animation {

	public static func start(duration: TimeInterval, animation: (Animator) -> Void, completion: ((Bool) -> Void)?) {
		let animator = Animator(duration: duration)

		if completion != nil {
			CATransaction.begin()
			CATransaction.setCompletionBlock {
				completion?(true)
			}
		}
		animation(animator)
		if completion != nil {
			CATransaction.commit()
		}
	}

	public static func start(duration: TimeInterval, animation: (Animator) -> Void) {
		self.start(duration: duration, animation: animation, completion: nil)
	}

}
