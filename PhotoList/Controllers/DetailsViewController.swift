import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //View model
    var viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol =  Injection.shared.container.resolve(DetailsViewModelProtocol.self)!) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        self.title = "Photo Details"
        if let photoData = self.viewModel.photoData {
            photoData.bind { [weak self] _ in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.titleLabel.text = self.viewModel.makeTitle()
                    if let url = self.viewModel.makeImageURL(){
                        self.photoImageView.sd_setImage(with: url)
                    }
                    self.descriptionLabel.text = self.viewModel.makeID()
                }
            }
        }
    }
}

