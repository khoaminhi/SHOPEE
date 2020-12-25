using ManageStore.DTO;
using System;
using System.Data;

namespace ManageStore.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set => BillDAO.instance = value;
        }
        private BillDAO() { }
        public int GetUnCheckBillIDByCustomerID(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT *FROM dbo.DONMUA WHERE IDKH = " + id);

            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;

        }
        public void CheckOut(int id, /*int discount,*/ float totalPrice)
        {
            string query = "UPDATE dbo.DONMUA SET NGAYMUA = GETDATE(), TTXEM = 1  WHERE IDKH = " + id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable", new object[] { id });
        }

        //public DataTable GetBillListByDate(DateTime checkIn, DateTime checkOut)
        //{

        //    //return DataProvider.Instance.ExecuteQuery("exec USP_GetListBillByDate @checkIn , @checkOut", new object[] { checkIn, checkOut });
        //}
        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExecuteScalar("Select MAX(id) from DONMUA");
            }
            catch
            {
                return 1;
            }

        }
    }
}
