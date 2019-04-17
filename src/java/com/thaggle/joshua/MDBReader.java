package com.thaggle.joshua;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.Index;
import com.healthmarketscience.jackcess.Index.Column;
import com.healthmarketscience.jackcess.Row;
import com.healthmarketscience.jackcess.Table;

public class MDBReader {

	public static void main(String[] args) throws Exception {
		List<String> pkStmts = new ArrayList<String>();
		List<String> fkDrops = new ArrayList<String>();
		List<String> fkCreates = new ArrayList<String>();
		Database db = DatabaseBuilder.open(new File("//_DATA_/JPHarvestField.mdb"));
		for(String table:db.getTableNames()) {
			System.out.println("-------------------------------");
			System.out.println(table);
			System.out.println("-------------------------------");
			Table tableObj = db.getTable(table);
			String pkCols = colNamesForIndex(tableObj.getPrimaryKeyIndex(),false);
			pkStmts.add("ALTER TABLE "+table+" ADD PRIMARY KEY ("+pkCols+");");
			
			for(Index idx:tableObj.getIndexes()) {
				if(idx.isForeignKey()) {
					//String referencedTableName = idx.getReferencedIndex().getTable().getName();
					String referencedIndexColNames = colNamesForIndex(idx.getReferencedIndex(),true);
					String thisIndexColNames = colNamesForIndex(idx,true);
					System.out.println(thisIndexColNames + " => " + referencedIndexColNames);
					//String fkCreate = "ALTER TABLE products ADD FOREIGN KEY fk_vendor(vdr_id) REFERENCES vendors(vdr_id)";
					String fkDrop = "ALTER TABLE "+idx.getReferencedIndex().getTable().getName()+" DROP FOREIGN KEY fk_"+tableObj.getName()+";";
					fkDrops.add(fkDrop);
					String fkCreate = "ALTER TABLE "+idx.getReferencedIndex().getTable().getName()+" ADD FOREIGN KEY fk_"+tableObj.getName()+"("+colNamesForIndex(idx.getReferencedIndex(),false)+") REFERENCES "+tableObj.getName()+"("+colNamesForIndex(idx.getReferencedIndex(),false)+");";
					fkCreates.add(fkCreate);
				}
			}
			System.out.println();
		}
		
		for(String stmt:pkStmts) {
			System.out.println(stmt);
		}
		System.out.println();
		for(String stmt:fkDrops) {
			System.out.println(stmt);
		}
		System.out.println();
		for(String stmt:fkCreates) {
			System.out.println(stmt);
		}
	}

	private static String colNamesForIndex(Index idx, boolean includeTableName) {
		StringBuffer cols = new StringBuffer();
		for(Column col:idx.getColumns()){
			String tableAndDot = includeTableName ? idx.getTable().getName() + "." : ""; 
			cols.append("," + tableAndDot + col.getName());
		}
		return cols.toString().substring(1, cols.toString().length());
	}

}
