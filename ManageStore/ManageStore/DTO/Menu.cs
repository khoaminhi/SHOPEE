using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
   public class Menu
    {
        private string productName;

        private int count;

        private float price;

        private float totalPricce;

        public Menu(string productName,int count, float price, float totalPrice=0)
        {
            this.ProductName = productName;
            this.Count = count;
            this.Price = price;
            this.TotalPricce = totalPrice;
        }

        public Menu(DataRow row)
        {
            this.ProductName = row["TENSP"].ToString();
            this.Count = (int)row["SOLUONGMUA"];
            this.Price = (float)Convert.ToDouble(row["GIASP"].ToString());
            this.TotalPricce = (float)Convert.ToDouble(row["totalPrice"].ToString());
        }

        public string ProductName { get => productName; set => productName = value; }
        public int Count { get => count; set => count = value; }
        public float Price { get => price; set => price = value; }
        public float TotalPricce { get => totalPricce; set => totalPricce = value; }
    }
}
