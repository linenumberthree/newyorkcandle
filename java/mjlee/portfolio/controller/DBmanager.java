package mjlee.portfolio.controller;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBmanager {
	public Connection c;

	
	/*
	 * 
mysql> desc members;
+----------+-------------+------+-----+-------------------+----------------+
| Field    | Type        | Null | Key | Default           | Extra          |
+----------+-------------+------+-----+-------------------+----------------+
| no       | int(11)     | NO   | PRI | NULL              | auto_increment |
| name     | varchar(20) | NO   |     | NULL              |                |
| id       | varchar(20) | NO   |     | NULL              |                |
| pw       | varchar(30) | NO   |     | NULL              |                |
| joindate | timestamp   | NO   |     | CURRENT_TIMESTAMP |                |
| ip       | varchar(30) | YES  |     | NULL              |                |
| address  | text        | YES  |     | NULL              |                |
| postNo   | varchar(10) | YES  |     | NULL              |                |
| mobileNo | varchar(20) | YES  |     | NULL              |                |
| email    | varchar(30) | YES  |     | NULL              |                |
+----------+-------------+------+-----+-------------------+----------------+
10 rows in set (0.00 sec)

	 * 
	 */
	
	
	public DBmanager() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Connection getConnection() {
		try {
			Context initContext= new InitialContext();
			Context envContext= (Context)initContext.lookup("java:/comp/env");
			DataSource db= (DataSource)envContext.lookup("jdbc/vigdsing");
			c= db.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
}
