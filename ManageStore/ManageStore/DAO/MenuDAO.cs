using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DAO
{
    class MenuDAO
    {
        private static MenuDAO instance;

        public static MenuDAO Instance
        {
            get { if (instance == null) instance = new MenuDAO(); return MenuDAO.instance; }
            private set => MenuDAO.instance = value;
        }

        private MenuDAO() { }
        public List<Menu> GetListMenuByCustomer(int id)
        {
            List<Menu> listMenu = new List<Menu>();

            string query = "SELECT f.TENSP, bi.SOLUONGMUA, f.GIASP, f.GIASP*bi.SOLUONGMUA AS totalPrice FROM CHITIETDM AS bi, DONMUA AS b, SANPHAM AS f WHERE bi.IDDM = b.IDDM AND bi.IDSP = f.IDSP AND b.IDKH  = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            
            foreach (DataRow item in data.Rows)
            {
                Menu menu = new Menu(item);
                listMenu.Add(menu);
            }    
            return listMenu;
        }
    }
}
