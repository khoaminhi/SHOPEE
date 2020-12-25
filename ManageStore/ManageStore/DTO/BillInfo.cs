using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    class BillInfo
    {
        public BillInfo( int billID,int productID,int count)
        {
            
            this.BillID = billID;
            this.ProductID = productID;
            this.Count = count;
        }

        public BillInfo(DataRow row)
        {
            
            this.BillID = (int)row["IDDM"];
            this.ProductID = (int)row["IDSP"];
            this.Count = (int)row["SOLUONGMUA"];
        }
        private int iD;

        private int billID;
        private int productID;
        private int count;

        public int ID { get => iD; set => iD = value; }
        public int BillID { get => billID; set => billID = value; }
        public int ProductID { get => productID; set => productID = value; }
        public int Count { get => count; set => count = value; }
    }
}
