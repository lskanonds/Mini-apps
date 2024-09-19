import UIKit

class CrosswordViewController: UIViewController {
    
    let words = [
        ("iOS", "Операционная система для iPhone и iPad"),
        ("Apple", "Фрукт"),
        ("Swift", "Язык программирования, который популярен в iOS разработке")
    ]
    
    var textFields: [UITextField] = []
    var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (word, description) in words {
            let descriptionLabel = UILabel()
            descriptionLabel.text = description
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.placeholder = "Введите слово на английском языке"
            textFields.append(textField) 
            
            stackView.addArrangedSubview(descriptionLabel)
            stackView.addArrangedSubview(textField)
        }
        
        // Кнопка проверки
        let checkButton = UIButton(type: .system)
        checkButton.setTitle("Проверить", for: .normal)
        checkButton.addTarget(self, action: #selector(checkAnswers), for: .touchUpInside)
        
        // Поле для результата
        resultLabel = UILabel()
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        stackView.addArrangedSubview(checkButton)
        stackView.addArrangedSubview(resultLabel)

        view.addSubview(stackView)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    @objc func checkAnswers() {
        var results: [String] = []
        
        for (index, textField) in textFields.enumerated() {
            let correctAnswer = words[index].0
            if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == correctAnswer.lowercased() {
                results.append("Слово верно!")
            } else {
                results.append("Слово неверно.")
            }
        }
        
        resultLabel.text = results.joined(separator: "\n")
    }
}
