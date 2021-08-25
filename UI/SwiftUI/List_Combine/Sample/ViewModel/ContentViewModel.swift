//
//  ContentViewModel.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/24.
//

import Foundation
import Combine

// ViewModelはView側への参照は持たない

// @ObservedObjectは、ObservableObjectプロトコルに準拠する必要がある
class ContentViewModel: ObservableObject {
    
    // 監視したいデータに対して、@Publishedを付与する
    @Published var rowDatas: [RowData] = []
    @Published var isLoading: Bool = false
 
    private var apiManager = ApiManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchArticles() {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        isLoading = true
        apiManager.retrieveData()
            // ストリームをメインスレッドへ流す
            .receive(on: DispatchQueue.main)
            // Publisherの出力した値をSubscribeして処理
            .sink(receiveCompletion: { completion in
                
                print("\(String(describing: type(of: self))) \(#function) sink")
                
                switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        print("error \(error.localizedDescription)")
                        self.isLoading = false
                }
                
            }, receiveValue: { response in
                
                print("\(String(describing: type(of: self))) \(#function) receiveValue")
                
                self.rowDatas = response
            })
            .store(in: &cancellables)
    }
}
