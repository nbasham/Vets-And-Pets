import UIKit

enum ModelValidationResult<T, String> {
    case sucssess(T)
    case failure(String)
}
final class VetInfoViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var vetTitle: UITextField!
    @IBOutlet weak var mission: UITextField!

    var model: VetModel? { return createViewModel() }
    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func createViewModel() -> VetModel? {
//        guard isValid else { return nil }
        return VetModel(id: id,
                        username: userName.text!,
                        firstName: firstName.text!,
                        lastName: lastName.text!,
                        title: vetTitle.text!,
                        mission: mission.text!
        )
    }
    var validateModel: ModelValidationResult<VetModel, String> {
        if let message = missingFieldsMessage {
            return .failure(message)
        } else if let model = self.model {
            return .sucssess(model)
        } else {
            return .failure("Unknown error.")
        }
    }
//    var isValid: Bool { return validate() == nil }

    private func validate() -> [String]? {
        return Practitioner.validate(
            first: firstName?.text,
            last: lastName?.text,
            user: userName?.text,
            title: vetTitle?.text,
            mission: mission?.text
        )
    }

    private func applyModel(_ model: VetModel) {
        firstName.text = model.firstName
        lastName.text = model.lastName
        userName.text = model.username
        vetTitle.text = model.title
        mission.text = model.mission
        id = model.id
    }

    private var missingFieldsMessage: String? {
        if let missing = validate() {
            return "The field(s): " + missing.joined(separator: ", ") + " are required."
        }
        return nil
    }

    func setup(action: String, model: VetModel? = nil) {
        title = "\(action) Vet"
        navigationController?.setLargeNavigation()
        rightButton(systemItem: .cancel, target: self, action: #selector(self.dismissViewController))
        actionButton.setTitle("\(action)", for: .normal)
        if let model = model {
            applyModel(model)
        }
    }
}
