using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    class Customer
    {
        public Customer(int id,string tenKH,string gioiTinh,DateTime ngaysinh,string email,string sdt)
        {
            this.ID = id;
            this.TenKH = tenKH;
            this.GioiTinh = gioiTinh;
            this.NgaySinh = ngaysinh;
            this.Email = email;
            this.Sdt = sdt;
        }
        public Customer(DataRow row)
        {
            this.ID = (int)row["IDKH"];
            this.TenKH = row["TENKH"].ToString();
            this.GioiTinh = row["GIOITINHKH"].ToString();
            this.NgaySinh = (DateTime?)row["NGAYSINHKH"];
            this.Email = row["EMAILKH"].ToString();
            this.Sdt = row["DIENTHOAIKH"].ToString();

        }
        private int iD;
        private string tenKH;
        private string gioiTinh;
        private DateTime? ngaySinh;
        private string email;
        private string sdt;

        public int ID { get => iD; set => iD = value; }
        public string TenKH { get => tenKH; set => tenKH = value; }
        public string GioiTinh { get => gioiTinh; set => gioiTinh = value; }
        public DateTime? NgaySinh { get => ngaySinh; set => ngaySinh = value; }
        public string Email { get => email; set => email = value; }
        public string Sdt { get => sdt; set => sdt = value; }
    }
}
