using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DAO
{
    class BillInfoDAO
    {
        private static BillInfoDAO instance;

        public static BillInfoDAO Instance {
            get {if(instance==null) instance=new BillInfoDAO();return BillInfoDAO.instance; }
            private set => instance = value; 
        }

        private BillInfoDAO()
        {

        }
        public List<BillInfo> GetListBillInfo(int id)
        {
            List<BillInfo> listBillInfo = new List<BillInfo>();
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.CHITIETDM WHERE IDDM = " + id);
            foreach (DataRow item in data.Rows)
            {
                BillInfo info = new BillInfo(item);
                listBillInfo.Add(info);
            }
            return listBillInfo;
        }
        public void InsertBillInfo(int idBill,int idProduct,int count)
        {

                DataProvider.Instance.ExecuteNonQuery("USP_InsertBillInfo @idBill , @idProduct , @count", new object[] { idBill, idProduct, count });
            
        }
        public void DeleteBillInfoByProductID(int id)
        {
            DataProvider.Instance.ExecuteQuery("DELETE dbo.CHITIETDM WHERE IDSP = " + id);
        }
    }
}
