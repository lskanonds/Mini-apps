import UIKit

class CalculatorViewController: UIViewController {
    
    var displayLabel: UILabel!
    var currentInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        displayLabel = UILabel()
        displayLabel.text = "0"
        displayLabel.font = UIFont.systemFont(ofSize: 48)
        displayLabel.textAlignment = .right
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(displayLabel)
        
        let buttonTitles = [
            ["1", "2", "3", "/"],
            ["4", "5", "6", "*"],
            ["7", "8", "9", "-"],
            ["0", "C", "=", "+"]
        ]
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for row in buttonTitles {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            
            for title in row {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            
            stackView.addArrangedSubview(rowStackView)
        }
        
        view.addSubview(stackView)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        switch title {
        case "C":
            currentInput = ""
            displayLabel.text = "0"
        case "=":
            calculateResult()
        default:
            currentInput += title
            displayLabel.text = currentInput
        }
    }
    
    func calculateResult() {
        let expression = NSExpression(format: currentInput.replacingOccurrences(of: "/", with: "/").replacingOccurrences(of: "*", with: "*").replacingOccurrences(of: "-", with: "-").replacingOccurrences(of: "+", with: "+"))
        
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            displayLabel.text = "\(result)"
            currentInput = "\(result)"
        } else {
            displayLabel.text = "Ошибка"
            currentInput = ""
        }
    }
}
