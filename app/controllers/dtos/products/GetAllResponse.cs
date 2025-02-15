using System.Collections.Generic;

namespace app.controllers.dtos.products
{
    public struct GetAllResponse
    {
        public List<ProductItem> Items { get; set; }
    }
}