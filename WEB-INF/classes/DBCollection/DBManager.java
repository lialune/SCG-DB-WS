package DBCollection;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class DBManager
{
	Connection mConn;
	Statement mStmt;

	public DBManager()
	{
		mConn = null;
		mStmt = null;
	}

	public boolean Connecting(String _DBPath, String _ID, String _Password, boolean _AutoCommit)
	{
		try
		{
			//Class.forName("com.mysql.jdbc.Driver");

			String jdbcDriver = _DBPath + "useUnicode=true&characterEncoding=euckr";
			mConn = DriverManager.getConnection(jdbcDriver, _ID, _Password);

			if(null != mConn)
			{
				mConn.setAutoCommit(_AutoCommit);
				mStmt = mConn.createStatement();
				return true;
			}
			else
			{
				Release();
				return false;
			}
		}
		catch(SQLException ex)
		{
			return false;
		}
	}

	public void Release()
	{
		if (mStmt != null) try { mStmt.close(); } catch(SQLException ex) {}
		if (mConn != null) try { mConn.close(); } catch(SQLException ex) {}
	}

	public String ReCombination(String _UUID)
	{
		String[] SplitData = _UUID.split("-");
		// timestemp1 + timestemp2 + timestemp3 + LANCardMacID
		String NewGuid =	SplitData[2].substring(1, SplitData[2].length() - 1) +
					SplitData[1] + SplitData[0] +SplitData[3]; 
		return NewGuid;
	}

	public String CreateInsertQuery(String _TableName, String[] _LableNames, String[] _Values)
	{
		String Query = "INSERT INTO " + _TableName + " (";

		for(int i = 0; _LableNames.length > i; ++i)
		{
			if(0 == i) Query += ", ";
			Query = Query + "'" + _LableNames[i] + "'";
		}
		Query = Query + ") VALUES (";

		for(int i = 0; _Values.length > i; ++i)
		{
			if(0 == i) Query += ", ";
			Query = Query + "'" + _Values[i] + "'";
		}
		Query += ")";

		return Query;
	}

	public String CreateInsertQuery(String _TableName, String _LableName, String _Value)
	{
		String Query = "INSERT INTO " + _TableName + " (" + _LableName + ") VALUES (" + _Value + ")";

		return Query;
	}

	public String CreateSelectQuery(String _TableName, String[] _LabelNames, String _Condition)
	{
		String Query = "SELECT ";
		for(int i = 0; _LabelNames.length > i; ++i)
		{
			Query += ("'" + _LabelNames[i] + "'");
			if(_LabelNames.length > i + 1)
			{
				Query += ", ";
			}
		}
		Query += (" FROM " + _TableName + " WHERE "+ _Condition);

		return Query;
	}

	public String CreateUUIDQuery()
	{
		return "SELECT UUID()";
	}

	public ResultSet ExcuteQuery(String _Query)
	{
		try
		{
			return mStmt.executeQuery(_Query);
		}
		catch(SQLException ex)
		{
			return null;
		}
	}

	public int ExcuteUpdate(String _Query)
	{
		try
		{
			return mStmt.executeUpdate(_Query);
		}
		catch(SQLException ex)
		{
			return -1;
		}
	}
}