import UIKit
import PrincipleAnimation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let view = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
		view.backgroundColor = .red
		self.view.addSubview(view)
		
		Animation.start(duration: 0.5, animation: {
			$0.add(duration: 0.5, delay: 0.0, curve: .physicSpring(tension: 0.8, friction: 0.5), block: {
				view.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
			})
			$0.add(duration: 0.4, curve: .physicSpring(tension: 5, friction: 0.5), block: {
				view.backgroundColor = .green
			})
		}) { (_) in
		}
	}
	
}

