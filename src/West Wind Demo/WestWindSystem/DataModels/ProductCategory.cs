using System.Collections.Generic;

namespace WestWindSystem.DataModels
{
    public class ProductCategory // A simple DTO class
    {
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public byte[] Picture { get; set; }
        public string MimeType { get; set; }
        public IEnumerable<ProductSummary> Products { get; set; }
    }
}
