using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DAO
{
    class InventoryDAO
    {

        private static InventoryDAO instance;

        public static InventoryDAO Instance
        {
            get { if (instance == null) instance = new InventoryDAO(); return InventoryDAO.instance; }
            private set => InventoryDAO.instance = value;
        }

        private InventoryDAO() { }
        public List<Inventory> GetListInventory()
        {
            List<Inventory> list = new List<Inventory>();
            string query = "select * from KHO";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Inventory inventory = new Inventory(item);
                list.Add(inventory);
            }

            return list;
        }
        public List<Inventory> SearchInventoryByName(string name)
        {
            List<Inventory> list = new List<Inventory>();
            string query = string.Format("SELECT * FROM dbo.KHO WHERE dbo.GetUnsignString(TENKHO) LIKE N'%' + dbo.GetUnsignString(N'{0}') + '%'", name);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Inventory Inventory = new Inventory(item);
                list.Add(Inventory);
            }

            return list;
        }
        public bool InsertInventory(int id, string name, string diachi)
        {

            //string query = string.Format("INSERT dbo.SANPHAM ( name, idCategory, price )VALUES  ( N'{0}', {1}, {2})", name, id, price);
            string query = string.Format("EXEC usp_insertInventory {0}, '{1}','{2}'", new object[] { id, name, diachi });
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool UpdateInventory(int id,int idnv,string tenkho,string diachi)
        {
            string query = string.Format("update dbo.KHO Set TENKHO='{0}', DIACHIKHO='{1}',IDNV={2} where IDKHO = {3}",new object[] {tenkho,diachi,idnv,id });
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool DeleteInventory(int idInventory)
        {
            BillInfoDAO.Instance.DeleteBillInfoByProductID(idInventory);

            string query = string.Format("exec usp_deleteInventory {0}", idInventory);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
