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

}
