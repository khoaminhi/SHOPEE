using ManageStore.DAO;
using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManageStore
{
    public partial class fSaler : Form
    {
        BindingSource productList = new BindingSource();
        BindingSource accountList = new BindingSource();

        public Account loginAccount;
        public fSaler()
        {

            InitializeComponent();
            Load();
        }
        void Load()
        {
            dtgvFood.DataSource = productList;
            

            LoadDateTimePickerBill();
            //LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListProduct();
        
            LoadCategoryIntoCombobox(cbFoodCategory);
            AddFoodBinding();
        }
        #region methods
        

        
        List<Product> SearchProductByName(string name)
        {
            List<Product> listProduct = ProductDAO.Instance.SearchProductByName(name);
            return listProduct;
        }
        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;
            dtpkFromDate.Value = new DateTime(today.Year, today.Month, 1);
            dtpkToDate.Value = dtpkFromDate.Value.AddMonths(1).AddDays(-1);
        }
        //void LoadListBillByDate(DateTime checkIn, DateTime checkOut)
        //{
        //    dtgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn, checkOut);
        //}
        void LoadListProduct()
        {
            productList.DataSource = ProductDAO.Instance.GetListProductByCusID(1);
        }
        void AddFoodBinding()
        {
            tbFoodName.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "name", true, DataSourceUpdateMode.Never));
            txbFoodID.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmFoodPrice.DataBindings.Add(new Binding("Value", dtgvFood.DataSource, "Price", true, DataSourceUpdateMode.Never));

        }

        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        
        #endregion

        #region events
        //private void btnViewBill_Click(object sender, EventArgs e)
        //{
        //    LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
        //}
        private void btnDisplayFood_Click(object sender, EventArgs e)
        {
            LoadListProduct();
        }
        private void txbFoodID_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (dtgvFood.SelectedCells.Count > 0)
                {
                    int id = (int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryID"].Value;

                    Category cateogory = CategoryDAO.Instance.GetCategoryByID(id);

                    cbFoodCategory.SelectedItem = cateogory;

                    int index = -1;
                    int i = 0;
                    foreach (Category item in cbFoodCategory.Items)
                    {
                        if (item.ID == cateogory.ID)
                        {
                            index = i;
                            break;
                        }
                        i++;
                    }

                    cbFoodCategory.SelectedIndex = index;
                }
            }
            catch { }

        }

        

       

        

        


        private void btnSearchFood_Click(object sender, EventArgs e)
        {
            productList.DataSource = SearchProductByName(tbSearchFoodName.Text);
        }
       



        #endregion

        private void fSaler_Load(object sender, EventArgs e)
        {

        }

        private void dtgvBill_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
