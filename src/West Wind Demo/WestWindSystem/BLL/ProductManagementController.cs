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
        #region Query Product Catalog
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
        #endregion

        #region Product Info CRUD Processing
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ProductInfo> FilterProducts(string partialName, bool includeDiscontinued)
        {
            using (var context = new WestWindContext())
            {
                var results = from item in context.Products
                              where item.ProductName.Contains(partialName)
                                 && (item.Discontinued == includeDiscontinued || !item.Discontinued)
                              select new ProductInfo
                              {
                                  ProductId = item.ProductID,
                                  Name = item.ProductName,
                                  Price = item.UnitPrice,
                                  QtyPerUnit = item.QuantityPerUnit,
                                  Supplier = item.Supplier.CompanyName,
                                  Category = item.Category.CategoryName,
                                  SupplierId = item.SupplierID,
                                  CategoryId = item.CategoryID
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        public void AddProductItem(ProductInfo info)
        {

        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public void UpdateProductItem(ProductInfo info)
        {

        }

        [DataObjectMethod(DataObjectMethodType.Delete)]
        public void DeleteProductItem(ProductInfo info)
        {

        }
        #endregion
    }
}
