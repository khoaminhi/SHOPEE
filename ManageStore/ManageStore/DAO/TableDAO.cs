﻿using ManageStore.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManageStore.DAO
{
    class TableDAO
    {
        private static TableDAO instance;

        internal static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO();return TableDAO.instance; }
            private set { TableDAO.instance = value; } 
        }

        public static int TableWidth = 90;
        public static int TableHeight = 90;
        private TableDAO()
        {

        }
        public void SwitchTable(int id1,int id2)
        {
            DataProvider.Instance.ExecuteQuery("USP_SwitchTable @idTable1 , @idTable2", new object[] { id1, id2 });
        }
        public List<TableDTO> LoadTableList()
        {
            List<TableDTO> tableList = new List<TableDTO>();

            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetTableList");

            foreach(DataRow item in data.Rows)
            {
                TableDTO table = new TableDTO(item);
                tableList.Add(table);
            }

            return tableList;
        }
    }
}
