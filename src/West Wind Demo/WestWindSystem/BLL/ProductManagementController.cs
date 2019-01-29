using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    [DataObject] // this class provides access to objects that can be DataBound to UI controls
    public class ProductManagementController
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ProductCategory> ListCurrentProducts()
        {
            using (var context = new WestWindContext())
            {
                // Apply my LinqPad query to this method
                var result = from cat in context.Categories
                             select new ProductCategory
                             {
                                 CategoryName = cat.CategoryName,
                                 Description = cat.Description,
                                 Picture = cat.Picture,
                                 MimeType = cat.PictureMimeType,
                                 Products = from item in cat.Products
                                            select new ProductSummary
                                            {
                                                Name = item.ProductName,
                                                Price = item.UnitPrice,
                                                Quantity = item.QuantityPerUnit
                                            }
                             };
                return result.ToList();
            }
        }
    }
}
