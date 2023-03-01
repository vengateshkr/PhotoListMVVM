
import UIKit
import Swinject

class PhotoListViewController: UIViewController {
    var viewModel:PhotoListViewModelProtocol!
    var photoListTableView : UITableView!
    var activityIndicator: UIActivityIndicatorView!
    var photosDataSource: [PhotoListTableCellViewModel] = []

    init(viewModel:PhotoListViewModelProtocol = Injection.shared.container.resolve(PhotoListViewModelProtocol.self)!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    func setupUI() {
        photoListTableView = UITableView()
        photoListTableView.dataSource = self
        photoListTableView.delegate = self
        photoListTableView.translatesAutoresizingMaskIntoConstraints = false
        photoListTableView.accessibilityIdentifier = "myUniqueTableViewIdentifier"

        self.view.addSubview(photoListTableView)
        
        photoListTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        photoListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        photoListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        photoListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        photoListTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PhotoTableViewCell")
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor(named:"SpinnerColor")
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func showAlert() {
        let dialogMessage = UIAlertController(title: "Error", message: "There is some API issue", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.title = "Photo List"
        setupUI()
        bindViewModel()
        viewModel.callPhotoListAPI()
    }
    
    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.shouldShowError.bind { [weak self] showError in
            guard let self = self,let showError = showError else {
                return
            }
            DispatchQueue.main.async {
                if showError {
                    self.showAlert()
                }
            }
        }
        
        viewModel.photos.bind { [weak self] photos in
            guard let self = self,
                  let photos = photos else {
                return
            }
            self.photosDataSource = photos
            self.photoListTableView.reloadData()
        }
    }
    
    func openDetails(photoId: Int) {
        guard let photo = viewModel.retrivePhoto(withId: photoId) else {
            return
        }
        
        DispatchQueue.main.async {
            let controller = DetailsViewController()
            controller.viewModel.selectedPhoto(photo)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
    
extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell
        cell?.selectionStyle = .none
        cell?.setupCell(viewModel: photosDataSource[indexPath.row])
        cell?.accessibilityIdentifier = "myCell_\(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoId = photosDataSource[indexPath.row].id
        self.openDetails(photoId: photoId)
    }
    
}
