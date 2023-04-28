import UIKit

class ViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let letters = [
                "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к",
                "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц",
                "ч", "ш" , "щ", "ъ", "ы", "ь", "э", "ю", "я"
            ]

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigueView()
        configueConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    func cofigueView() {
        view.addSubview(collectionView)
    }

    func configueConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    //количество ячеек в секции
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.text = letters[indexPath.row]
        return cell!
    }
    //сама ячейка для заданной позиции IndexPath
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
        default:
            id = ""
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! SupplementaryView
        view.titleLabel.text = "Здесь назодится Supplementary View"
        return view
    }
    //возвращать хедер и футер для каждой секции
}


extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
}

    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
    //задаёт размеры для каждой ячейки
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    //задаёт минимальный отступ между строками коллекции
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    //задаёт минимальный отступ между ячейками
    */
    
extension ViewController: UICollectionViewDelegateFlowLayout { // 1 Для управления расположением и размерами элементов (включая размеры хедера) нужно реализовать методы из протокола
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { // 2 реализуем метод, получает на вход объект коллекции, layout и номер секции, а возвращает её (секции) размер.
        
        let indexPath = IndexPath(row: 0, section: section) // 3 Так как мы получили только номер секции, теперь нам нужно самим собрать структуру IndexPath для дальнейшего использования
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) // 4 Получаем у коллекции View — так же, как мы делали это для ячеек. Но на этот раз используем немного другой метод
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                         withHorizontalFittingPriority: .required,
                                                         verticalFittingPriority: .fittingSizeLevel)// 5 передаём View возможность посчитать свой размер и вернуть его. Зная текст, мы могли бы рассчитать высоту View, но такой подход более универсален: он фиксирует ширину View по размеру коллекции, но даёт ей рассчитать свою высоту самостоятельно исходя из констрейнтов. Если вы заглянете в код SupplementaryView, то увидите, что мы задали лейблу верхний и нижний констрейнты к самой View. От размеров лейбла и будет зависеть высота всей View
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)
        
        return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 1 Мы добавляем реализацию метода
        return CGSize(width: collectionView.bounds.width / 2, height: 50)   // 2 Берём ширину коллекции и делим на два, чтобы на каждой строке помещалось ровно по две ячейки. Высоту выставляем
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
