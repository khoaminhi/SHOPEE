using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DAO
{

    public class ProductDAO
    {
        private static ProductDAO instance;

        public static ProductDAO Instance
        {
            get { if (instance == null) instance = new ProductDAO(); return ProductDAO.instance; }
            private set => instance = value;
        }

        private ProductDAO() { }

        public List<Product> GetListCategoryID(int id)
        {
            List<Product> list = new List<Product>();
            string query = "select * from SANPHAM where IDDANHMUC = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Product product = new Product(item);
                list.Add(product);
            }

            return list;
        }
        public List<Product> GetListProduct()
        {
            List<Product> list = new List<Product>();
            string query = "select * from SANPHAM";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Product product = new Product(item);
                list.Add(product);
            }

            return list;
        }
        public List<Product> GetListProductByCusID(int id)
        {
            List<Product> list = new List<Product>();
            string query = "	SELECT DISTINCT * FROM dbo.SANPHAM JOIN dbo.SANPHAMKB ON SANPHAMKB.IDSP = SANPHAM.IDSP WHERE dbo.SANPHAMKB.IDKH= " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Product product = new Product(item);
                list.Add(product);
            }

            return list;
        }

        public List<Product> SearchProductByName(string name)
        {
            List<Product> list = new List<Product>();
            string query = string.Format("SELECT * FROM dbo.SANPHAM WHERE dbo.GetUnsignString(name) LIKE N'%' + dbo.GetUnsignString(N'{0}') + '%'", name);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Product product = new Product(item);
                list.Add(product);
            }

            return list;
        }
        public bool InsertProduct(string name, int id, float price)
        {
            string query = string.Format("INSERT dbo.SANPHAM ( name, idCategory, price )VALUES  ( N'{0}', {1}, {2})", name, id, price);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool UpdateProduct(int idFood, string name, int id, float price)
        {
            string query = string.Format("UPDATE dbo.SANPHAM SET TENSP = N'{0}', IDDANHMUC = {1}, GIASP = {2} WHERE IDSP = {3}", name, id, price, idFood);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool DeleteProduct(int idProduct)
        {
            BillInfoDAO.Instance.DeleteBillInfoByProductID(idProduct);

            string query = string.Format("Delete SANPHAM where id = {0}", idProduct);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
