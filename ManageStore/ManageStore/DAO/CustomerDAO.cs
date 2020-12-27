using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace ManageStore.DAO
{
    class CustomerDAO
    {
        private static CustomerDAO instance;

        public static CustomerDAO Instance
        {
            get { if (instance == null) instance = new CustomerDAO(); return CustomerDAO.instance; }
            private set => CustomerDAO.instance = value;
        }

        private CustomerDAO() { }
        public List<Customer> GetListCustomer()
        {
            List<Customer> list = new List<Customer>();
            string query = "select * from KHACHHANG";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Customer customer = new Customer(item);
                list.Add(customer);
            }

            return list;
        }
        public List<Customer> SearchCustomerByName(string name)
        {
            List<Customer> list = new List<Customer>();
            string query = string.Format("SELECT * FROM KHACHHANG WHERE dbo.GetUnsignString(TENKH) LIKE N'%' + dbo.GetUnsignString(N'{0}') + '%'", name);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Customer Customer = new Customer(item);
                list.Add(Customer);
            }

            return list;
        }
    }
}
