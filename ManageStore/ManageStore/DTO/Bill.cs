using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    public class Bill
    {
        private int iD;

        

        private DateTime? dateCheckIn;

        private int status;

        public Bill(int id, DateTime? dateCheckIn, int status)
        {
            this.ID = id;
            this.DateCheckIn = dateCheckIn;
            
            this.Status = status;
            
        }
        public Bill(DataRow row)
        {
            this.ID = (int)row["IDDM"];
            this.DateCheckIn = (DateTime?)row["NGAYMUA"];
            //var dateCheckOutTemp = row["dateCheckOut"];
            //if (dateCheckOutTemp.ToString() != "")
            //    this.DateCheckOut = (DateTime?)dateCheckOutTemp;
            //this.Status = (int)row["status"];
            //if (row["discount"].ToString() != "")
            //    this.Discount = (int)row["discount"];

        }

        private int discount;
        public int ID
        {
            get => iD;
            set => iD = value;
        }
        //public DateTime? DateCheckOut { get => dateCheckOut; set => dateCheckOut = value; }
        public DateTime? DateCheckIn { get => dateCheckIn; set => dateCheckIn = value; }
        public int Status { get => status; set => status = value; }
        public int Discount { get => discount; set => discount = value; }
    }
}
