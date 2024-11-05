final class DisplayProductCatalogModelSource {
    func prepareDisplayModel(model: ProductCatalogModel.Res) -> ProductCatalog.DisplayModel {
        return ProductCatalog.DisplayModel(
            products: model.products.map {
                .init(
                    title: $0.title,
                    price: String($0.price),
                    stock: "Quantity is \($0.stock)",
                    thumbnail: $0.thumbnail
                )
            }
        )
    }
}
