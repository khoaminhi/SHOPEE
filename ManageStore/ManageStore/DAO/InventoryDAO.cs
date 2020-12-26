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
    }
}
