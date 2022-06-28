package mjlee.portfolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import mjlee.portfolio.controller.DBmanager;

public class ProductDao {
	private Connection c;
	private PreparedStatement ps;
	private ResultSet r;
	private ArrayList<CandleDto> candleList;
	private int res;
	private String rString="";
	public ProductDao() {
		c= new DBmanager().getConnection();
		candleList= new ArrayList<>();
	}
	
/*
 * public CandleDto(String candleName, String scentName, String effectName, String placeName, int productNo,
			int goodsCatNo, int scentNo, int effectNo, int placeNo)
 * 
 */
	
	public int getCandleCount() {
		String query= "select count(*) from candle";
		try {
			ps= c.prepareStatement(query);
			r= ps.executeQuery(); r.next();
			res= r.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	public ArrayList<CandleDto> getAllCandles(int pageNo){
		String query= "select candle.*, (select scentName from candleScent where candle.scentNo=candleScent.scentNo) as `scentName`, (select effectName from candleEffect where candle.effectNo=candleEffect.effectNo) as `effectName`, (select placeName from candlePlace where candle.placeNo=candlePlace.placeNo) as `placeName`, (select optionPrice from candleOption where candle.productNo=candleOption.productNo and candleOption.optionName='S') as `optionPrice` from candle order by candle.productNo limit ?, 10;";
		try {
			ps= c.prepareStatement(query);
			ps.setInt(1, (pageNo-1)*10);
			r= ps.executeQuery();
			while(r.next()) {
				candleList.add(new CandleDto(r.getString("candleName"), r.getString("scentName"), r.getString("effectName"), r.getString("placeName"), r.getInt("productNo"), r.getInt("goodsCatNo"), r.getInt("scentNo"), r.getInt("effectNo"), r.getInt("placeNo"), r.getInt("optionPrice"), r.getString("thumbnailImg"), r.getString("detailImg")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return candleList;
	}
	
	public ArrayList<CandleDto> mainCandles(){
		String query= "select productNo,candleName,thumbnailImg from candle order by productNo limit 0, 3";
		try {
			ps= c.prepareStatement(query);
			r= ps.executeQuery();
			while(r.next()) {
				candleList.add(new CandleDto(r.getInt("productNo"),  r.getString("candleName"), r.getString("thumbnailImg")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return candleList;
	}
	
	public JsonArray search(String[] scent, String[] effect, String[] place){
		String Query= "select candle.*, (select scentName from candleScent where candle.scentNo=candleScent.scentNo) as `scentName`, (select effectName from candleEffect where candle.effectNo=candleEffect.effectNo) as `effectName`, (select placeName from candlePlace where candle.placeNo=candlePlace.placeNo) as `placeName`, (select optionPrice from candleOption where candle.productNo=candleOption.productNo and candleOption.optionName='S') as `optionPrice` from candle where (";
		boolean first=true;
		JsonArray list= new JsonArray();
		if(scent!=null) {
			for(int i=0; i<scent.length; i++) {
				if(first) {first=false;} else {Query+=" || ";}
				Query += "scentNo="+scent[i];
			}
			Query += ")"; first=true;
		}
		if(effect!=null) {
			if(Query.contains("where (scentNo")) {
				Query+="||(";
			}
			for(int i=0; i<effect.length; i++) {
				if(first) {first=false;} else {Query+=" || ";}
				Query +="effectNo="+effect[i];
			}
			Query+=")"; first=true;
		}
		if(place!=null) {
			if(Query.contains("where (scentNo") || Query.contains("where (effectNo")) {
				Query+="||(";
			}
			for(int i=0; i<place.length; i++) {
				if(first) {first=false;} else {Query+=" || ";}
				Query +="placeNo="+place[i];
			}
			Query+=")";
		}
		if(scent==null && effect==null && place==null) {
			Query= "select candle.*, (select scentName from candleScent where candle.scentNo=candleScent.scentNo) as `scentName`, (select effectName from candleEffect where candle.effectNo=candleEffect.effectNo) as `effectName`, (select placeName from candlePlace where candle.placeNo=candlePlace.placeNo) as `placeName`, (select optionPrice from candleOption where candle.productNo=candleOption.productNo and candleOption.optionName='S') as `optionPrice` from candle order by candle.productNo limit 0, 10;";
		}
		
		try {
			ps= c.prepareStatement(Query);
			r= ps.executeQuery();
			
			while(r.next()) {
				JsonObject temp= new JsonObject();
				temp.addProperty("productNo", r.getInt("productNo"));
				temp.addProperty("candleName", r.getString("candleName"));
				temp.addProperty("scentName", r.getString("scentName"));
				temp.addProperty("effectName", r.getString("effectName"));
				temp.addProperty("placeName", r.getString("placeName"));
				temp.addProperty("optionPrice", r.getInt("optionPrice"));
				temp.addProperty("thumbnailImg", r.getString("thumbnailImg"));
				temp.addProperty("detailImg", r.getString("detailImg"));
				list.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public JsonArray searchProductByName(String name) {
		String query= "select candle.*, (select scentName from candleScent where candle.scentNo=candleScent.scentNo) as `scentName`, "
				+ "(select effectName from candleEffect where candle.effectNo=candleEffect.effectNo) as `effectName`, "
				+ "(select placeName from candlePlace where candle.placeNo=candlePlace.placeNo) as `placeName`, "
				+ "(select optionPrice from candleOption where candle.productNo=candleOption.productNo and candleOption.optionName='S') as `optionPrice` "
				+ "from candle where instr(candle.candleName, ?)>0";
		JsonArray list= new JsonArray();
		try {
			ps= c.prepareStatement(query);
			ps.setString(1, name);
			r= ps.executeQuery();
			while(r.next()) {
				JsonObject temp= new JsonObject();
				temp.addProperty("productNo", r.getInt("productNo"));
				temp.addProperty("candleName", r.getString("candleName"));
				temp.addProperty("scentName", r.getString("scentName"));
				temp.addProperty("effectName", r.getString("effectName"));
				temp.addProperty("placeName", r.getString("placeName"));
				temp.addProperty("optionPrice", r.getInt("optionPrice"));
				temp.addProperty("thumbnailImg", r.getString("thumbnailImg"));
				temp.addProperty("detailImg", r.getString("detailImg"));
				list.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public int getOptionPrice(int productNo, String optionVal) {
		String Query= "select o.optionPrice as `optionPrice` from candleOption as `o` join candle as `c` on o.productNo=c.productNo where o.optionName= ? and c.productNo= ?";
		try {
			ps= c.prepareStatement(Query);
			ps.setInt(2, productNo);
			if(optionVal==null) {
				ps.setString(1, "S");
			}else {
				ps.setString(1, optionVal);
			}
			r= ps.executeQuery();
			while(r.next()) {
				res= r.getInt("optionPrice");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return res;
	}
	
	public CandleDto getProductInfo(int category, int goodsNo) {
		CandleDto res= new CandleDto();
		String query="";
		try {
			switch(category) {
				case 1: query="select c.*, e.effectName, s.scentName, p.placeName, o.optionName, o.optionPrice from candle `c` left join candleEffect `e` on c.effectNo=e.effectNo"
						+ "    		left join candleScent `s` on c.scentNo=s.scentNo"
						+ "    		left join candlePlace `p` on c.placeNo=p.placeNo"
						+ "   		left join candleOption `o` on c.productNo=o.productNo and o.optionName='S'"
						+ "		where c.productNo=?"; break;
			}
			ps= c.prepareStatement(query);
			ps.setInt(1, goodsNo);
			r= ps.executeQuery();
			while(r.next()) {
				res.setCandleName(r.getString("candleName"));
				res.setEffectName(r.getString("effectName"));
				res.setPlaceName(r.getString("placeName"));
				res.setScentName(r.getString("scentName"));
				res.setProductNo(r.getInt("productNo"));
				res.setOptionPrice(r.getInt("optionPrice"));
				res.setThumbnailImg(r.getString("thumbnailImg"));
				res.setDetailImg(r.getString("detailImg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return res;
	}
	
	public boolean addToCart(MemberDto dto, int catNo, int productNo, String option, int count) {
		String query1="insert into cart (memberNo) values (?)";
		String query2="insert into cartDetail (cartNo, goodsCatNo, productNo, productOption, cartCount) values ((select cartNo from cart where cart.memberNo= ?), ?, ?, ?, ?)";
		try {
			ps= c.prepareStatement("select count(*) `c` from cart where memberNo= ?");
			ps.setInt(1, dto.getNo());
			r= ps.executeQuery(); r.next();
			System.out.println(".................1");
			if(r.getInt("c")>0) {
				ps= c.prepareStatement("select count(*) `c2` from cartDetail where productNo= ? and productOption= ? and cartNo=(select cartNo from cart where memberNo= ?)");
				ps.setInt(1, productNo);
				ps.setString(2, option);
				ps.setInt(3, dto.getNo());
				r= ps.executeQuery(); r.next();
				if(r.getInt("c2")>0) {
					ps= c.prepareStatement("update cartDetail set cartCount=cartCount+ ? where productNo= ? and productOption= ? and cartNo=(select cartNo from cart where memberNo= ?)");
					ps.setInt(1, count);
					ps.setInt(2, productNo);
					ps.setString(3, option);
					ps.setInt(4, dto.getNo());
					if(ps.executeUpdate()>0) {
						return true;
					}else {
						return false;
					}
				}else {
					ps= c.prepareStatement(query2);
					ps.setInt(1, dto.getNo());
					ps.setInt(2, catNo);
					ps.setInt(3, productNo);
					ps.setString(4, option);
					ps.setInt(5, count);
					if(ps.executeUpdate()>0) {
						System.out.println(".................2");
						return true;
					}else {
						System.out.println(".................3");
						return false;
					}
				}
			}else {
				ps= c.prepareStatement(query1);
				ps.setInt(1, dto.getNo());
				System.out.println(".................4");
				if(ps.executeUpdate()>0) {
					ps= c.prepareStatement(query2);
					ps.setInt(1, dto.getNo());
					ps.setInt(2, catNo);
					ps.setInt(3, productNo);
					ps.setString(4, option);
					ps.setInt(5, count);
					if(ps.executeUpdate()>0) {
						System.out.println(".................5");
						return true;
					}else {
						System.out.println(".................6");
						return false;
					}
				}else {
					System.out.println(".................7");
					return false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	/*
	 * mysql> select candle.*, cart.*, cartDetail.* from cartDetail join cart on cartDetail.cartNo=cart.cartNo left join candle on cartDetail.productNo=candle.productNo where cart.memberNo=1;
+-----------+------------+---------------+---------+----------+---------+---------------------+---------+---------+--------+----------+---------------------+--------------+--------+------------+-----------+-----------+
| productNo | goodsCatNo | candleName    | scentNo | effectNo | placeNo | productDate         | adminNo | adminIp | cartNo | memberNo | cartDate            | cartDetailNo | cartNo | goodsCatNo | productNo | cartCount |
+-----------+------------+---------------+---------+----------+---------+---------------------+---------+---------+--------+----------+---------------------+--------------+--------+------------+-----------+-----------+
|         3 |          1 | 시트러스 윈드 |       1 |        3 |       2 | 2022-02-09 18:04:55 |       1 | 1.1.1.1 |      1 |        1 | 2022-02-15 02:28:19 |            1 |      1 |          1 |         3 |         2 |
|         5 |          1 | 베이비 파우더 |       4 |        4 |       2 | 2022-02-09 18:05:42 |       1 | 1.1.1.1 |      1 |        1 | 2022-02-15 02:28:19 |            2 |      1 |          1 |         5 |         1 |
+-----------+------------+---------------+---------+----------+---------+---------------------+---------+---------+--------+----------+---------------------+--------------+--------+------------+-----------+-----------+
2 rows in set (0.00 sec)
	 */
	
	public JsonArray getCart(int memberNo){
		String query= "select candle.*, cart.*, cartDetail.*, candleOption.optionPrice from cartDetail join cart on cartDetail.cartNo=cart.cartNo left join candle on cartDetail.productNo=candle.productNo right - candleOption on cartDetail.productNo=candleOption.productNo and candleOption.optionName=cartDetail.productOption where cart.memberNo= ?";
		JsonArray list= new JsonArray();
		try {
			ps= c.prepareStatement(query);
			ps.setInt(1, memberNo);
			r= ps.executeQuery();
			while(r.next()) {
				JsonObject temp= new JsonObject();
				temp.addProperty("productNo", r.getInt("productNo"));
				temp.addProperty("candleName", r.getString("candleName"));
				temp.addProperty("optionPrice", r.getInt("optionPrice"));
				temp.addProperty("option", r.getString("productOption"));
				temp.addProperty("count", r.getInt("cartCount"));
				temp.addProperty("thumbnailImg", r.getString("thumbnailImg"));
				list.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public boolean updateCart(int count, int productNo, String option, int memberNo) {
		try {
			ps= c.prepareStatement("update cartDetail set cartCount= ? where productNo= ? and productOption= ? and cartNo=(select cartNo from cart where memberNo= ?)");
			ps.setInt(1, count);
			ps.setInt(2, productNo);
			ps.setString(3, option);
			ps.setInt(4, memberNo);
			if(ps.executeUpdate()>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean resetCart(int memberNo) {
		try {
			ps= c.prepareStatement("delete from cartDetail where cartNo=(select cartNo from cart where memberNo= ?)");
			ps.setInt(1, memberNo);
			if(ps.executeUpdate()>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteCart(int productNo, String option, int memberNo) {
		try {
			ps= c.prepareStatement("delete from cartDetail where productNo= ? and productOption= ? and cartNo=(select cartNo from cart where memberNo=?) ");
			ps.setInt(1, productNo);
			ps.setString(2, option);
			ps.setInt(3, memberNo);
			if(ps.executeUpdate()>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
