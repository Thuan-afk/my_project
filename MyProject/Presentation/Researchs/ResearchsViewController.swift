import Foundation
import UIKit
import SnapKit
import RxSwift

class ResearchsViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.register(ResearchTableViewCell.self, forCellReuseIdentifier: ResearchTableViewCell.reuseIdentifier)
        return v
    }()
    
    private let viewModel = ResearchsViewModel()
    private let disposeBag = DisposeBag()
    
    weak var delegate: HomeViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.researchsInit()
    }
    
    override func setupViews() {
        view.addSubview(tableView)
    }
    
    override func updateConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func bindViewModel() {
        viewModel.researchs
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] research in
                    self?.tableView.reloadData()
                }
            )
            .disposed(by: disposeBag)
    }

}

extension ResearchsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let research = viewModel.researchs.value[indexPath.row]
        delegate?.goToViewController(research: research)
    }
}

extension ResearchsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.researchs.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResearchTableViewCell.reuseIdentifier, for: indexPath) as? ResearchTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.researchs.value[indexPath.row]
        cell.setName(name: item.rawValue)
        
        return cell
    }
}
