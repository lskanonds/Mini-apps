import UIKit

class MainViewController: UIViewController {
    
    let apps = ["Погода", "Кроссворд", "Калькулятор", "Кликер"]
    var appInstances: [AppInstance] = []
    
    struct AppInstance {
        let name: String
        let color: UIColor
        let font: UIFont
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        generateAppInstances()
        setupTableView()
    }
    
    func generateAppInstances() {
        for app in apps {
            let color: UIColor
            
            switch app {
            case "Погода":
                color = .red
            case "Кроссворд":
                color = .blue
            case "Калькулятор":
                color = .orange
            case "Кликер":
                color = .purple
            default:
                color = .gray
            }
            
            let randomFontSize = CGFloat.random(in: 16...24)
            let randomFont = UIFont.systemFont(ofSize: randomFontSize)
            appInstances.append(AppInstance(name: app, color: color, font: randomFont))
        }
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AppCell.self, forCellReuseIdentifier: "AppCell")
        view.addSubview(tableView)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Две секции
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? appInstances.count * 2 : apps.count //
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? view.bounds.height / 8 : view.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instanceIndex = indexPath.row < appInstances.count ? indexPath.row : indexPath.row - appInstances.count
        
        let instance = appInstances[instanceIndex]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppCell
        cell.configure(with: instance.name, color: instance.color, font: instance.font)
        
        if indexPath.section == 0 {
            cell.isUserInteractionEnabled = false
            cell.alpha = 0.5
            
           
            let randomColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 0.5)
            cell.contentView.backgroundColor = randomColor
            
        } else {
            cell.isUserInteractionEnabled = true
            cell.alpha = 1.0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        
        let appName = apps[indexPath.row]
        var vc: UIViewController
        
        switch appName {
        case "Погода":
            vc = WeatherViewController()
        case "Кроссворд":
            vc = CrosswordViewController()
        case "Калькулятор":
            vc = CalculatorViewController()
        case "Кликер":
            vc = ClickerViewController()
        default:
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


class AppCell: UITableViewCell {
    
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with appName: String, color: UIColor, font: UIFont) {
        label.text = appName
        label.font = font 
        contentView.backgroundColor = color
    }
}
