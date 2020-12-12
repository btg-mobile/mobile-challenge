//
//  ViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 07/12/20.
//

import Lottie
import UIKit

class ExchangeViewController: UITableViewController, Storyboarded {
    static func instantiate() -> Self? {
        return nil
    }

    var  viewModel: ExchangeViewModel?
    var  currencyViewModel: SupportedCurrenciesViewModel?
    var  animationView: AnimationView?
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        viewModel?.initApplication(tableView: self.tableView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playHomeAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playHomeAnimation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
           traitCollection.userInterfaceStyle == .dark ? setupAnimationView() : setupAnimationView()
        }
    }

    func playHomeAnimation() {
        animationView?.play()
        animationView?.loopMode = .loop
    }

    func setupAnimationView() {
        let strokeKeyPath = AnimationKeypath(keypath: "**.Group 1.Stroke 1.Color")
        let fillKeyPath = AnimationKeypath(keypath: "**.Group 1.Fill 1.Color")
        let colorProvider = ColorValueProvider(Colors.primaryColor!.lottieColorValue)
        animationView?.animationSpeed = 0.1
        animationView?.setValueProvider(colorProvider, keypath: strokeKeyPath)
        animationView?.setValueProvider(colorProvider, keypath: fillKeyPath)
    }

    // MARK: - Outlets

    @IBOutlet weak var currencyConvertedLabel: UILabel!
    @IBOutlet weak var currencyCountryLabel: UILabel!
    @IBOutlet weak var currencyCountryShortLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.text = Strings.ExchangeScreen.amountLabel
        }
    }

    @IBOutlet weak var fromLabel: UILabel! {
        didSet {
            fromLabel.text = Strings.ExchangeScreen.fromLabel
        }
    }

    @IBOutlet weak var toLabel: UILabel! {
        didSet {
            toLabel.text = Strings.ExchangeScreen.toLabel
        }
    }

    @IBOutlet weak var amountTextInput: UITextField! {
        didSet {
            //Adding a Done Button above the keyboard
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(onPressDone))

            doneButton.tintColor = Colors.labelColor
            toolbar.sizeToFit()
            toolbar.setItems([flexibleSpace, doneButton], animated: true)

            amountTextInput.keyboardType = UIKeyboardType.decimalPad
            amountTextInput.inputAccessoryView = toolbar
        }
    }

    @IBOutlet weak var homeAnimationView: AnimationView! {
        didSet {
            animationView = .init(name: "homeAnimation")
            animationView?.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            animationView?.contentMode = .scaleAspectFit
            homeAnimationView.addSubview(animationView!)
        }
    }

    @IBOutlet weak var currenciesListButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "list.bullet",
                withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.primaryColor!, renderingMode: .alwaysOriginal)
            currenciesListButton.setTitle("", for: .normal)
            currenciesListButton.setImage(buttonIcon, for: .normal)
        }
    }

    @IBOutlet weak var updateCurrencyButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "goforward", withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.primaryColor!, renderingMode: .alwaysOriginal)
            updateCurrencyButton.setTitle("", for: .normal)
            updateCurrencyButton.setImage(buttonIcon, for: .normal)
        }
    }

    @IBOutlet weak var switchCurrencyButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.whiteLabelColor, renderingMode: .alwaysOriginal)
            switchCurrencyButton.setImage(buttonIcon, for: .normal)
            switchCurrencyButton.setTitle("", for: .normal)
            switchCurrencyButton.layer.cornerRadius = 10
            switchCurrencyButton.backgroundColor = Colors.primaryColor
        }
    }

    @IBOutlet weak var fromButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.labelColor, renderingMode: .alwaysOriginal)
            fromButton.contentHorizontalAlignment = .left
            fromButton.setTitle(Strings.ExchangeScreen.formButton, for: .normal)
            fromButton.setTitleColor(Colors.labelColor, for: .normal)
            fromButton.setImage(buttonIcon, for: .normal)
            fromButton.layer.cornerRadius = 5
        }
    }

    @IBOutlet weak var toButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.labelColor, renderingMode: .alwaysOriginal)
            toButton.contentHorizontalAlignment = .left
            toButton.setTitle(Strings.ExchangeScreen.toButton, for: .normal)
            toButton.setTitleColor(Colors.labelColor, for: .normal)
            toButton.setImage(buttonIcon, for: .normal)
            toButton.layer.cornerRadius = 5
        }
    }

    @IBOutlet weak var convertButton: UIButton! {
        didSet {
            convertButton.setTitle(Strings.ExchangeScreen.convertButton, for: .normal)
            convertButton.setTitleColor(Colors.whiteLabelColor, for: .normal)
            convertButton.backgroundColor = Colors.primaryColor
            convertButton.layer.cornerRadius = 5
        }
    }

    // MARK: - Actions

    @objc func onPressDone() {
        view.endEditing(true)
    }
    @IBAction func goToCurrenciesScreen(_ sender: Any) {
        coordinator?.goToCurrenciesScreen(with: currencyViewModel!)
    }
    @IBAction func updateCurrencyValues(_ sender: Any) {
    }
    @IBAction func onPressFrom(_ sender: Any) {
    }
    @IBAction func onPressTo(_ sender: Any) {
    }
    @IBAction func onPressConvert(_ sender: Any) {
    }

}
