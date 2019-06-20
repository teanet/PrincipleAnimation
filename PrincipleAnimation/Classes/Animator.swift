public class Animator {

	public enum Curve {
		case linear
		case timingFunction(CAMediaTimingFunction)
		case spring(damping: CGFloat)
		case physicSpring(tension: CGFloat, friction: CGFloat)
		var options: UIView.AnimationOptions {
			switch self {
			case .linear: return .curveLinear
			default: return []
			}
		}
	}

	let duration: TimeInterval
	init(duration: TimeInterval) {
		self.duration = duration
	}

	public func add(withRelativeStartTime: Double, relativeDuration: Double, curve: Curve = .linear, block: @escaping () -> Void) {
		self.add(duration: self.duration * relativeDuration, delay: self.duration * withRelativeStartTime, curve: curve, block: block)
	}

	public func add(duration: TimeInterval, delay: TimeInterval = 0, curve: Curve = .linear, completion: ((Bool) -> Void)? = nil, block: @escaping () -> Void) {
		if case .timingFunction(let function) = curve {
			CATransaction.begin()
			CATransaction.setAnimationTimingFunction(function)
		}
		switch curve {
		case .spring(let damping):
			UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [], animations: block, completion: completion)
		case .physicSpring(let tension, let friction):
			let damping = self.dampingRatio(tension: tension, friction: friction)
			let duration = self.duration(tension: tension, friction: friction)
			UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [], animations: block, completion: completion)
		default:
			UIView.animate(withDuration: duration, delay: delay, options: curve.options, animations: block, completion: completion)
		}
		if case .timingFunction(_) = curve {
			CATransaction.commit()
		}
	}

	private func dampingRatio(tension: CGFloat, friction: CGFloat) -> CGFloat {
		let damping = friction / sqrt(2 * (1 * tension))
		return damping
	}

	private func duration(tension: CGFloat, friction: CGFloat, velocity: CGFloat = 0.0, mass: CGFloat = 1.0) -> TimeInterval {
		let dampingRatio = self.dampingRatio(tension: tension, friction: friction)
		let undampedFrequency = sqrt(tension / mass)

		let epsilon: CGFloat = 0.001

		// This is basically duration extracted out of the envelope functions
		guard dampingRatio < 1 else { return 0 }

		let a = sqrt(1 - pow(dampingRatio, 2))
		let b = velocity / (a * undampedFrequency)
		let c = dampingRatio / a
		let d = -((b - c) / epsilon)
		guard d > 0 else { return 0 }

		let duration = Darwin.log(Double(d)) / Double(dampingRatio * undampedFrequency)
		return TimeInterval(duration)
	}

}
