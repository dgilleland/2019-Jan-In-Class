namespace BackEnd.DataModels
{
    public class Item
    {
        public int ItemId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double Quantity { get; set; }
        public decimal TotalItemPrice { get; set; }
        public bool Sold { get; set; }
    }
}
