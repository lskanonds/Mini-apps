import UIKit

class ClickerViewController: UIViewController {
    
    private var count = 0
    private let countLabel = UILabel()
    private let clickButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        countLabel.text = "Счет: \(count)"
        countLabel.font = UIFont.systemFont(ofSize: 24)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        clickButton.setTitle("Кликни меня!", for: .normal)
        clickButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        clickButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(countLabel)
        view.addSubview(clickButton)
        
       
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20), 
            
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func buttonClicked() {
        count += 1
        countLabel.text = "Счет: \(count)"
    }
}
