using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    class Inventory
    {
        
        public Inventory(int id, string tenKho, string diachiKho)
        {
            this.ID = id;
            this.TenKHO = tenKho;
            this.DiaChiKho = diachiKho;
           
        }
        public Inventory(DataRow row)
        {
            this.ID = (int)row["IDKHO"];
            this.TenKHO = row["TENKHO"].ToString();
            this.DiaChiKho = row["DIACHIKHO"].ToString();
            
        }
        private int iD;
        private string tenKHO;
        private string diaChiKho;

        public int ID { get => iD; set => iD = value; }
        public string TenKHO { get => tenKHO; set => tenKHO = value; }
        public string DiaChiKho { get => diaChiKho; set => diaChiKho = value; }
    }
}
