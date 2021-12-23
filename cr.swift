//
//  Netguru iOS code review task
//

class paymentViewController: UIViewController {
    
    weak var delegate: PaymentViewControllerDelegate?
    let customView = PaymentView()
    let payment: Payment?
    internal let viewModel: PaymentViewModel?

    func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        view.addSubview(customView)
        updateBackground()
        fetchPayment()
        callbacks()
    }
    
    func setupViewModel(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
    }
    
    func updateBackground() {
        view.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
    }

    func fetchPayment() {
        guard let viewModel = viewModel else { return }
        
        viewModel.fetchPayment()

//        customView.statusText = "Fetching data"
//        ApiClient.sharedInstance().fetchPayment { [weak self] payment in
//            guard let self = self else { return }
//            self.customView.isEuro = (payment?.currency ?? "") == "EUR" ? true : false
//            if (payment?.amount ?? 0) != 0 {
//                self.updatePaymentAmount(amountStr: "\(payment?.amount ?? 0)")
//                return
//            }
//        }
    }
    
    func callbacks() {
        customView.didTapButton = {
            if let payment = self.payment {
                self.delegate.didFinishFlow(amount: payment.amount
                                            currency: payment.currency)
            }
        }
    }
    
    func updatePaymentAmount(amountStr: String) {
        DispatchQueue.main.async {
            self.customView.updateTitleLabel(amountStr)
        }
    }
}
