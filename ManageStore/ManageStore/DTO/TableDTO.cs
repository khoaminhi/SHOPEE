﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DTO
{
    public class TableDTO
    {
        public TableDTO(int id,string name,string status)
        {
            this.ID = id;
            this.Name = name;
            this.Status = status;
        }

        public TableDTO(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.Status = row["status"].ToString();
        }

        private string status;

        private string name;

        private int iD;

        public int ID 
        { 
            get => iD; 
            set => iD = value; 
        }
        public string Name { get => name; set => name = value; }
        public string Status { get => status; set => status = value; }
    }
}
