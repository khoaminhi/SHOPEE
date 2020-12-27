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
    public partial class fAdmin : Form
    {
        BindingSource productList = new BindingSource();
        BindingSource accountList = new BindingSource();
        BindingSource customerList = new BindingSource();
        BindingSource inventoryList = new BindingSource();

        public Account loginAccount;
        public fAdmin()
        {
            
            InitializeComponent();
            Load();
        }
        void Load()
        {
            dtgvProduct.DataSource = productList;
            dtgvAccount.DataSource = accountList;
            dtgvCus.DataSource = customerList;
            dtgvInventory.DataSource = inventoryList;
            LoadDateTimePickerBill();
            //LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListProduct();
            LoadListCustomer();
            LoadAccount();
            LoadListInventory();
            AddAccountBinding();
            //LoadCategoryIntoCombobox(cbCategory);
            AddFoodBinding();
            //AddInventoryBinding();
        }
        #region methods
        void AddAccountBinding()
        {
            tbUserName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "UserName", true, DataSourceUpdateMode.Never));
            tbDisplayName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "DisplayName", true, DataSourceUpdateMode.Never));
            numericUpDown1.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "Type", true, DataSourceUpdateMode.Never));
        }

        void LoadAccount()
        {
            accountList.DataSource = AccountDAO.Instance.GetListAccount();
        }
        List<Product> SearchProductByName(string name)
        {
            List<Product> listProduct = ProductDAO.Instance.SearchProductByName(name);

            return listProduct;
        }
        List<Customer> SearchCustomerByName(string name)
        {
            List<Customer> listCustomer = CustomerDAO.Instance.SearchCustomerByName(name);

            return listCustomer;
        }
        List<Inventory> SearchInventoryByName(string name)
        {
            List<Inventory> listInventory = InventoryDAO.Instance.SearchInventoryByName(name);

            return listInventory;
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
            productList.DataSource = ProductDAO.Instance.GetListProduct();
        }
        void LoadListCustomer()
        {
            customerList.DataSource = CustomerDAO.Instance.GetListCustomer();
        }
        void LoadListInventory()
        {
            inventoryList.DataSource = InventoryDAO.Instance.GetListInventory();
        }
        void AddFoodBinding()
        {
            tbName.DataBindings.Add(new Binding("Text", dtgvProduct.DataSource, "name",true,DataSourceUpdateMode.Never));
            txbFoodID.DataBindings.Add(new Binding("Text", dtgvProduct.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmPrice.DataBindings.Add(new Binding("Value", dtgvProduct.DataSource, "Price", true, DataSourceUpdateMode.Never));
            
        }
        //void AddInventoryBinding()
        //{
        //    tbInvName.DataBindings.Add(new Binding("Text", dtgvProduct.DataSource, "TENKHO", true, DataSourceUpdateMode.Never));
        //    nmIDStaff.DataBindings.Add(new Binding("Text", dtgvProduct.DataSource, "IDNV", true, DataSourceUpdateMode.Never));
        //    tbInvAdr.DataBindings.Add(new Binding("Text", dtgvProduct.DataSource, "DIACHIKHO", true, DataSourceUpdateMode.Never));

        //}

        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        void AddAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.InsertAccount(userName, displayName, type))
            {
                MessageBox.Show("Thêm tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Thêm tài khoản thất bại");
            }

            LoadAccount();
        }

        void EditAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.UpdateAccount(userName, displayName, type))
            {
                MessageBox.Show("Cập nhật tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Cập nhật tài khoản thất bại");
            }

            LoadAccount();
        }

        void DeleteAccount(string userName)
        {
            if (loginAccount.UserName.Equals(userName))
            {
                MessageBox.Show("Vui lòng đừng xóa chính bạn chứ");
                return;
            }
            if (AccountDAO.Instance.DeleteAccount(userName))
            {
                MessageBox.Show("Xóa tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Xóa tài khoản thất bại");
            }

            LoadAccount();
        }

        void ResetPass(string userName)
        {
            if (AccountDAO.Instance.ResetPassword(userName))
            {
                MessageBox.Show("Đặt lại mật khẩu thành công");
            }
            else
            {
                MessageBox.Show("Đặt lại mật khẩu thất bại");
            }
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
        //private void txbFoodID_TextChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        if (dtgvProduct.SelectedCells.Count > 0)
        //        {
        //            int id = (int)dtgvProduct.SelectedCells[0].OwningRow.Cells["CategoryID"].Value;

        //            Category cateogory = CategoryDAO.Instance.GetCategoryByID(id);

        //            cbCategory.SelectedItem = cateogory;

        //            int index = -1;
        //            int i = 0;
        //            foreach (Category item in cbCategory.Items)
        //            {
        //                if (item.ID == cateogory.ID)
        //                {
        //                    index = i;
        //                    break;
        //                }
        //                i++;
        //            }

        //            cbCategory.SelectedIndex = index;
        //        }
        //    }
        //    catch { }

        //}

        //private void btnAddFood_Click(object sender, EventArgs e)
        //{
        //    string name = tbFoodName.Text;
        //    int categoryID = (cbFoodCategory.SelectedItem as Category).ID;
        //    float price = (float)nmFoodPrice.Value;

        //    if (FoodDAO.Instance.InsertFood(name, categoryID, price))
        //    {
        //        MessageBox.Show("Thêm món thành công");
        //        LoadListProduct();
        //        if (insertFood != null)
        //            insertFood(this, new EventArgs());
        //    }
        //    else
        //    {
        //        MessageBox.Show("Có lỗi khi thêm thức ăn");
        //    }

        //}
        private void btnAddFood_Click(object sender, EventArgs e)
        {
            string name = tbName.Text;
            int categoryID = (int)nmIDDM.Value;
            float price = (float)nmPrice.Value;
            string mota = tbDes.Text;
            string anh = tbPic.Text;
            string thuonghieu = tbBrand.Text;
            int tinhtrang = (int)numericTT.Value;

            if (ProductDAO.Instance.InsertProduct(categoryID, name, mota,anh,null,thuonghieu,price,null,tinhtrang))
            {
                MessageBox.Show("Thêm thành công");
                LoadListProduct();
                if (insertProduct != null)
                    insertProduct(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm");
            }

        }

        private void btnEditFood_Click(object sender, EventArgs e)
        {
            string name = tbName.Text;
            int categoryID = (int)nmIDDM.Value;
            float price = (float)nmPrice.Value;
            int id = Convert.ToInt32(txbFoodID.Text);

            if (ProductDAO.Instance.UpdateProduct(id, name, categoryID, price))
            {
                MessageBox.Show("Sửa thành công");
                LoadListProduct();
                if (updateProduct != null)
                    updateProduct(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa");
            }

        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbFoodID.Text);

            if (ProductDAO.Instance.DeleteProduct(id))
            {
                MessageBox.Show("Xóa thành công");
                LoadListProduct();
                if (deleteProduct != null)
                    deleteProduct(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa");
            }
        }

        private event EventHandler insertFood;
        public event EventHandler InsertFood
        {
            add { insertFood += value; }
            remove { insertFood -= value; }
        }
        private event EventHandler insertProduct;
        public event EventHandler InsertProduct
        {
            add { insertProduct += value; }
            remove { insertProduct -= value; }
        }
        private event EventHandler insertInventory;
        public event EventHandler InsertInventory
        {
            add { insertInventory += value; }
            remove { insertInventory -= value; }
        }

        private event EventHandler deleteFood;
        public event EventHandler DeleteFood
        {
            add { deleteFood += value; }
            remove { deleteFood -= value; }
        }
        private event EventHandler deleteProduct;
        public event EventHandler DeleteProduct
        {
            add { deleteProduct += value; }
            remove { deleteProduct -= value; }
        }
        private event EventHandler deleteInventory;
        public event EventHandler DeleteInventory
        {
            add { deleteInventory += value; }
            remove { deleteInventory -= value; }
        }
        private event EventHandler updateFood;
        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { updateFood -= value; }
        }
        private event EventHandler updateProduct;
        public event EventHandler UpdateProduct
        {
            add { updateProduct += value; }
            remove { updateProduct -= value; }
        }
        private event EventHandler updateInventory;
        public event EventHandler UpdateInventory
        {
            add { updateInventory += value; }
            remove { updateInventory -= value; }
        }

        private void btnSearchFood_Click(object sender, EventArgs e)
        {
            productList.DataSource = SearchProductByName(tbSearchFoodName.Text);
        }
        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            string userName = tbUserName.Text;
            string displayName = tbDisplayName.Text;
            int type = (int)numericUpDown1.Value;

            AddAccount(userName, displayName, type);
        }

        private void btnEditAccount_Click(object sender, EventArgs e)
        {
            string userName = tbUserName.Text;
            string displayName = tbDisplayName.Text;
            int type = (int)numericUpDown1.Value;

            EditAccount(userName, displayName, type);
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            string userName = tbUserName.Text;

            DeleteAccount(userName);
        }
        private void btnViewAccount_Click(object sender, EventArgs e)
        {
            LoadAccount();
        }
        private void btnResetPassWord_Click(object sender, EventArgs e)
        {
            string userName = tbUserName.Text;

            ResetPass(userName);
        }

        private void SearchCus_Click(object sender, EventArgs e)
        {
            customerList.DataSource = SearchCustomerByName(tbSearchCus.Text);
        }
        private void btnSearchInven_Click(object sender, EventArgs e)
        {
            inventoryList.DataSource = SearchInventoryByName(tbSearchInven.Text);
        }
        #endregion

        private void fAdmin_Load(object sender, EventArgs e)
        {

        }

        private void btnAddTable_Click(object sender, EventArgs e)
        {
            string name = tbInvName.Text;
            int staffID = (int)nmIDStaff.Value;     
            string address = tbInvAdr.Text;

            if (InventoryDAO.Instance.InsertInventory(staffID,name,address))
            {
                MessageBox.Show("Thêm thành công");
                LoadListInventory();
                if (insertInventory != null)
                    insertInventory(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm");
            }

        }

        private void btnEditTable_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(tbInvID.Text);
            string name = tbInvName.Text;
            int staffID = (int)nmIDStaff.Value;
            string address = tbInvAdr.Text;

            if (InventoryDAO.Instance.UpdateInventory(id,staffID, name, address))
            {
                MessageBox.Show("Sửa thành công");
                LoadListInventory();
                if (updateInventory != null)
                    updateInventory(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa");
            }

        }

        private void btnDeleteTable_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(tbInvID.Text);

            if (InventoryDAO.Instance.DeleteInventory(id))
            {
                MessageBox.Show("Xóa thành công");
                LoadListInventory();
                if (deleteInventory != null)
                    deleteInventory(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa");
            }
        }

        private void btnViewBill_Click(object sender, EventArgs e)
        {
            
        }
    }
}
