import Foundation

protocol ProductServicing {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

struct ProductService: ProductServicing {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let dummyProducts: [Product] = [
            .init(id: 1, name: "더미 운동화", price: 120000, description: "통기성이 좋은 경량 러닝화"),
            .init(id: 2, name: "더미 백팩", price: 89000, description: "노트북 수납이 가능한 일상용 백팩"),
            .init(id: 3, name: "더미 무선 이어폰", price: 159000, description: "액티브 노이즈 캔슬링 지원"),
            .init(id: 4, name: "더미 스마트워치", price: 299000, description: "건강 측정 기능이 풍부한 스마트워치"),
            .init(id: 5, name: "더미 텀블러", price: 19000, description: "보온·보냉이 뛰어난 스테인리스 텀블러")
        ]

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            completion(.success(dummyProducts))
        }
    }
}
