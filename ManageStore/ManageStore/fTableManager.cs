using ManageStore.DAO;
using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

using System.Windows.Forms;
using static System.Windows.Forms.ListViewItem;
using Menu = ManageStore.DTO.Menu;

namespace ManageStore
{
    public partial class fTableManager : Form
    {
        
        private Account loginAccount;

        public Account LoginAccount { get => loginAccount; set { loginAccount = value; ChangeAccount(loginAccount.Type); } }

        public fTableManager(Account acc)
        {
            if(acc.Type==1)
            {
                InitializeComponent();
                this.LoginAccount = acc;
                //LoadTable();
                LoadListProduct();
                //LoadCategory();
            }
        }

       
        
        #region Method
        void ChangeAccount(int type)
        {
            adminToolStripMenuItem.Enabled = type == 1;
            thôngTinCáNhânToolStripMenuItem.Text += " (" + LoginAccount.DisplayName + ")";
        }
        void LoadCategory()
        {
            List<Category> listCategory = CategoryDAO.Instance.GetListCategory();
            cbCategory.DataSource = listCategory;
            cbCategory.DisplayMember = "TENDANHMUC";
        }
        void LoadFoodListByCategoryID(int id)
        {
            List<Product> listProduct = ProductDAO.Instance.GetListCategoryID(id);
            comboBox2.DataSource = listProduct;
            comboBox2.DisplayMember = "TENSP";
        }


        void LoadTable()
        {

            flpTable.Controls.Clear();
            List<TableDTO> tableList=  TableDAO.Instance.LoadTableList();
            
            foreach(TableDTO item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + item.Status;
                btn.Click += btn_Click;
                btn.Tag = item;

                switch(item.Status)
                {
                    case "Trống":
                        btn.BackColor = Color.Aqua;
                        break;
                    default:
                        btn.BackColor = Color.LightPink;
                        break;
                }
                flpTable.Controls.Add(btn);
            }
        }
        void LoadListProduct()
        {

            flpTable.Controls.Clear();
            List<Product> tableList = ProductDAO.Instance.GetListProduct();

            foreach (Product item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + item.Price;
                btn.Click += btn_Click;
                btn.Tag = item;

                flpTable.Controls.Add(btn);
            }
        }
        void showBill(int id)
        {
            lsvBill.Items.Clear();
            List<Menu> listBillInfo = MenuDAO.Instance.GetListMenuByCustomer(id);
            float totalPrice = 0;
            foreach (Menu item in listBillInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.ProductName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPricce.ToString());
                totalPrice += item.TotalPricce;
                lsvBill.Items.Add(lsvItem);
            }
            CultureInfo culture = new CultureInfo("vi-VN");
            //Thread.CurrentThread.CurrentCulture = culture;
            txbTotalPrice.Text = totalPrice.ToString("c",culture);



            //List<BillInfo> listBillInfo = BillInfoDAO.Instance.GetListBillInfo(BillDAO.Instance.GetUnCheckBillIDByCusID(id));

            //foreach (BillInfo item in listBillInfo)
            //{
            //    ListViewItem lsvItem = new ListViewItem(item.ProductID.ToString());
            //    lsvItem.SubItems.Add(item.Count.ToString());

            //    lsvBill.Items.Add(lsvItem);

            //}
        }

        void loadComboBoxTable(ComboBox cb)
        {
            cb.DataSource = TableDAO.Instance.LoadTableList();
            cb.DisplayMember = "Name";
        }
        #endregion

        #region Events
       /* private void btn_Click(object sender, EventArgs e)
        {
            int tableID = ((sender as Button).Tag as TableDTO).ID;
            lsvBill.Tag = (sender as Button).Tag;
            showBill(tableID);
        }*/
        private void btn_Click(object sender, EventArgs e)
        {
            int cusID = 1;

            Customer cus = lsvBill.Tag as Customer;

            int idBill = BillDAO.Instance.GetUnCheckBillIDByCustomerID(1);
            int productID = ((sender as Button).Tag as Product).ID;
            int count = (int)nmFoodCount.Value;
            if (count != 0)
            {
                if (idBill == -1)
                {
                    BillDAO.Instance.InsertBill(1);
                    BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIDBill(), productID, count);
                }
                else
                {
                    BillInfoDAO.Instance.InsertBillInfo(idBill, productID, count);
                }
            }

            showBill(1);
            showBill(cusID);
        }
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile(LoginAccount);
            f.UpdateAccount += f_UpdateAccount;
            f.ShowDialog();
        }

        void f_UpdateAccount(object sender, AccountEvent e)
        {
            thôngTinTàiKhoảnToolStripMenuItem.Text = "Thông tin tài khoản (" + e.Acc.DisplayName + ")";
        }
        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAdmin f = new fAdmin();
            f.loginAccount = LoginAccount;
            f.InsertFood += f_InsertFood;
            f.DeleteFood += f_DeleteFood;
            f.UpdateFood += f_UpdateFood;
            f.ShowDialog();
        }
        void f_InsertFood(object sender, EventArgs e)
        {
            LoadFoodListByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                showBill(1);
        }
        void f_DeleteFood(object sender, EventArgs e)
        {
            LoadFoodListByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                showBill(1);
            //LoadTable();
        }
        void f_UpdateFood(object sender, EventArgs e)
        {
            LoadFoodListByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                showBill((1));
        }
        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0;
            ComboBox cb = sender as ComboBox;
            if(cb.SelectedItem == null)
            {
                return;
            }
            Category selected = cb.SelectedItem as Category;
            id = selected.ID;
            LoadFoodListByCategoryID(id);
        }

        private void addFoodbtn_Click(object sender, EventArgs e)
        {
            Customer cus = lsvBill.Tag as Customer;
                
            int idBill = BillDAO.Instance.GetUnCheckBillIDByCustomerID(1);
            int productID = (comboBox2.SelectedItem as Product).ID;
            int count =(int) nmFoodCount.Value;
            if (count != 0) {
                if (idBill == -1)
                {
                    BillDAO.Instance.InsertBill(cus.ID);
                    BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIDBill(), productID, count);
                }
                else
                {
                    BillInfoDAO.Instance.InsertBillInfo(idBill, productID, count);
                }
            }
            
            showBill(1);
            LoadTable();
        }
        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            Customer cus = lsvBill.Tag as Customer;

            int idBill = BillDAO.Instance.GetUnCheckBillIDByCustomerID(1);
            int discount = (int)nmDiscount.Value;
            double totalPrice = Convert.ToDouble(txbTotalPrice.Text.Split(',')[0].Replace(".", ""));
            double finalTotalPrice = totalPrice - (totalPrice / 100) * discount;
            if(idBill!=-1)
            {
                if (MessageBox.Show(string.Format("Bạn có chắc thanh toán hóa đơn \n Tổng tiền - (Tổng tiền/100) x Giảm giá\n = {1} - ({1} / 100) x {2} = {3}", 1 , totalPrice, discount, finalTotalPrice), "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill,  (float)finalTotalPrice);
                    showBill(1);
                    lsvBill.Items.Clear();             
                }
            }    
        }

       


        #endregion

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void kháchBánToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fSaler f = new fSaler();
            f.ShowDialog();
        }
    }
}
