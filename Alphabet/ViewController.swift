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
        //collectionView.delegate = self
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
}

/*
 //не понимаю, зачем нам нужен был делегат?
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
    //задаёт размеры для каждой ячейки
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    //задаёт минимальный отступ между строками коллекции
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    //задаёт минимальный отступ между ячейками
    
}
*/
