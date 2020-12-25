using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    class Customer
    {
        public Customer(int id)
        {
            this.ID = id;
           
        }
        public Customer(DataRow row)
        {
            this.ID = (int)row["id"];
            
        }
        private int iD;

        public int ID { get => iD; set => iD = value; }
    }
}
