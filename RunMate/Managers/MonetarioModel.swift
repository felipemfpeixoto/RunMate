//  Store.swift
//  PecanhaCaller
//
//  Created by Pedro Peçanha on 22/05/24.
//

import Foundation
import StoreKit

typealias Transaction = StoreKit.Transaction
typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

public enum StoreError: Error {
    case failedVerification
}


class MonetarioModel: NSObject, ObservableObject  {
    
    
    @Published var purchasedNonConsumableProducts: [Product] = []
    @Published var nonConsumableProducts: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    @Published var pizzaIsUnlocked = false
    @Published var sushiIsUnlocked = false
    var updateListenerTask: Task<Void, Error>? = nil
    
    
    override init() {
        
        super.init()
        
        print(Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt")
                
        Task {
            await requestProducts()
            
            await refreshPurchasedProducts()
            updateListenerTask = listenForTransactions()
            
        }
        
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    await self.refreshPurchasedProducts()
                    
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            //ids dos produtos que voce pode comprar.
            let storeProducts = try await Product.products(for: ["A4B7I24I4", "99878"])
            
            for product in storeProducts {
                switch product.type {
                case .nonConsumable:
//                    Adiciona na lista de nonConsumable
                    nonConsumableProducts.append(product)
                default:
                    print("Unknown product")
                }
            }
            
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            
            switch verification {
            case .unverified(let transaction, let verificationError):
                return nil
            case .verified(let transaction)://se a pessoa terminou a transação
                await refreshPurchasedProducts()
                
                await transaction.finish()
                
                return transaction
            }
            
            
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func isPurchased(_ product: Product) async throws -> Bool {
        //Determine whether the user purchases a given product.
        switch product.type {
        case .nonConsumable:
            return nonConsumableProducts.contains(product)
        default:
            return false
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
    
    //pega as compras do usuario
    @MainActor
    func refreshPurchasedProducts() async {
        var nonConsumables: [Product] = []
        
        //Iterate through all of the user's purchased products.
        for await result in Transaction.currentEntitlements {
            
            switch result {
            case .verified(let transaction):
                switch transaction.productType {
                case .nonConsumable:
                    if let coin = nonConsumableProducts.first(where: { $0.id == transaction.productID }) {
                        nonConsumables.append(coin)
                    }
                default:
                    break
                }
                
            case .unverified(let transaction, let error):
                print(error)
            }
            
        }
        // produtos que comprou -> purchasedNonConsumableProducts
        // produtos que comprou -> nonConsumables
        self.purchasedNonConsumableProducts = nonConsumables
        
    }
    
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
}
