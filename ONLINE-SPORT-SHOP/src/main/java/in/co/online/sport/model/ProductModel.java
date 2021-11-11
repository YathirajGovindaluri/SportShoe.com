package in.co.online.sport.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import in.co.online.sport.bean.CategoryBean;
import in.co.online.sport.bean.ProductBean;
import in.co.online.sport.exception.ApplicationException;
import in.co.online.sport.exception.DatabaseException;
import in.co.online.sport.exception.DuplicateRecordException;
import in.co.online.sport.util.JDBCDataSource;

public class ProductModel {
	
	private static Logger log = Logger.getLogger(ProductModel.class);

	/**
	 * Find next PK of Role
	 * 
	 * @throws DatabaseException
	 */
	public Integer nextPK() throws DatabaseException {
		log.debug("Model nextPK Started");
		Connection conn = null;
		int pk = 0;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ID) FROM s_Product");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				pk = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new DatabaseException("Exception : Exception in getting PK");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model nextPK End");
		return pk + 1;
	}
	
	public ProductBean findByName(String name) throws ApplicationException {
		log.debug("Model findBy EmailId Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM s_Product WHERE NAME=?");
		ProductBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new ProductBean();
				bean.setId(rs.getLong(1));
				bean.setCategoryId(rs.getLong(2));
				bean.setCategoryName(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setPrice(rs.getLong(5));
				bean.setDescription(rs.getString(6));
				bean.setImage(rs.getString(7));
				bean.setCreatedBy(rs.getString(8));
				bean.setModifiedBy(rs.getString(9));
				bean.setCreatedDatetime(rs.getTimestamp(10));
				bean.setModifiedDatetime(rs.getTimestamp(11));
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting User by emailId");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findBy EmailId End");
		return bean;
	}
	
	
	public ProductBean findByNameAndCategory(String name,long catId) throws ApplicationException {
		log.debug("Model findBy EmailId Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM s_Product WHERE NAME=? and categoryId=?");
		ProductBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, name);
			pstmt.setLong(2,catId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new ProductBean();
				bean.setId(rs.getLong(1));
				bean.setCategoryId(rs.getLong(2));
				bean.setCategoryName(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setPrice(rs.getLong(5));
				bean.setDescription(rs.getString(6));
				bean.setImage(rs.getString(7));
				bean.setCreatedBy(rs.getString(8));
				bean.setModifiedBy(rs.getString(9));
				bean.setCreatedDatetime(rs.getTimestamp(10));
				bean.setModifiedDatetime(rs.getTimestamp(11));
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting User by emailId");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findBy EmailId End");
		return bean;
	}
	
	
	public ProductBean findByPK(long pk) throws ApplicationException {
		log.debug("Model findByPK Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM s_Product WHERE ID=?");
		ProductBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, pk);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new ProductBean();
				bean.setId(rs.getLong(1));
				bean.setCategoryId(rs.getLong(2));
				bean.setCategoryName(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setPrice(rs.getLong(5));
				bean.setDescription(rs.getString(6));
				bean.setImage(rs.getString(7));
				bean.setCreatedBy(rs.getString(8));
				bean.setModifiedBy(rs.getString(9));
				bean.setCreatedDatetime(rs.getTimestamp(10));
				bean.setModifiedDatetime(rs.getTimestamp(11));
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting User by pk");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findByPK End");
		return bean;
	}
	
	public long add(ProductBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model add Started");
		Connection conn = null;
		int pk = 0;
		ProductBean duplicataRole = findByNameAndCategory(bean.getName(),bean.getCategoryId());

		// Check if create Role already exist
		if (duplicataRole != null) {
			throw new DuplicateRecordException("Product already exists this Category");
		}
		
		CategoryModel cModel=new CategoryModel();
		CategoryBean cBean=cModel.findByPK(bean.getCategoryId());
		bean.setCategoryName(cBean.getName());
		
		try {
			conn = JDBCDataSource.getConnection();
			pk = nextPK();

			// Get auto-generated next primary key
			System.out.println(pk + " in ModelJDBC");
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO s_Product VALUES(?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pk);
			pstmt.setLong(2, bean.getCategoryId());
			pstmt.setString(3,bean.getCategoryName());
			pstmt.setString(4, bean.getName());
			pstmt.setLong(5,bean.getPrice());
			pstmt.setString(6, bean.getDescription());
			pstmt.setString(7, bean.getImage());
			pstmt.setString(8, bean.getCreatedBy());
			pstmt.setString(9, bean.getModifiedBy());
			pstmt.setTimestamp(10, bean.getCreatedDatetime());
			pstmt.setTimestamp(11, bean.getModifiedDatetime());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : add rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in add Role");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model add End");
		return pk;
	}
	
	public void delete(ProductBean bean) throws ApplicationException {
		log.debug("Model delete Started");
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM s_Product WHERE ID=?");
			pstmt.setLong(1, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			// log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in delete Role");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model delete Started");
	}
	
	
	public void update(ProductBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model update Started");
		Connection conn = null;
		ProductBean duplicataRole = findByNameAndCategory(bean.getName(),bean.getCategoryId());

		// Check if updated Role already exist
		if (duplicataRole != null && duplicataRole.getId() != bean.getId()) {
			throw new DuplicateRecordException("Product already exists in this Category");
		}
		CategoryModel cModel=new CategoryModel();
		CategoryBean cBean=cModel.findByPK(bean.getCategoryId());
		bean.setCategoryName(cBean.getName());
		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE s_Product SET categoryId=?,categoryName=?,NAME=?,price=?,DESCRIPTION=?,image=?,CREATEDBY=?,MODIFIEDBY=?,CREATEDDATETIME=?,MODIFIEDDATETIME=? WHERE ID=?");
			pstmt.setLong(1, bean.getCategoryId());
			pstmt.setString(2,bean.getCategoryName());
			pstmt.setString(3, bean.getName());
			pstmt.setLong(4,bean.getPrice());
			pstmt.setString(5, bean.getDescription());
			pstmt.setString(6, bean.getImage());
			pstmt.setString(7, bean.getCreatedBy());
			pstmt.setString(8, bean.getModifiedBy());
			pstmt.setTimestamp(9, bean.getCreatedDatetime());
			pstmt.setTimestamp(10, bean.getModifiedDatetime());
			pstmt.setLong(11, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception in updating Role ");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model update End");
	}
	
	
	public List search(ProductBean bean) throws ApplicationException {
        return search(bean, 0, 0);
    }

    /**
     * Search Role with pagination
     * 
     * @return list : List of Roles
     * @param bean
     *            : Search Parameters
     * @param pageNo
     *            : Current Page No.
     * @param pageSize
     *            : Size of Page
     * 
     * @throws DatabaseException
     *  @throws ApplicationException
     */
    public List search(ProductBean bean, int pageNo, int pageSize)
            throws ApplicationException {
        log.debug("Model search Started");
        StringBuffer sql = new StringBuffer("SELECT * FROM s_Product WHERE 1=1");
        if (bean != null) {
            if (bean.getId() > 0) {
                sql.append(" AND id = " + bean.getId());
            }
            if (bean.getCategoryId() > 0) {
                sql.append(" AND CategoryId = " + bean.getCategoryId());
            }
            if (bean.getName() != null && bean.getName().length() > 0) {
				sql.append(" AND NAME LIKE '" + bean.getName() + "%'");
            }
            if (bean.getCategoryName() != null && bean.getCategoryName().length() > 0) {
				sql.append(" AND CategoryName LIKE '" + bean.getCategoryName() + "%'");
            }
            if (bean.getDescription() != null
                    && bean.getDescription().length() > 0) {
				sql.append(" AND DESCRIPTION LIKE '" + bean.getDescription()
                        + "%'");
            }
        }

        // if page size is greater than zero then apply pagination
        if (pageSize > 0) {
            // Calculate start record index
            pageNo = (pageNo - 1) * pageSize;
            sql.append(" Limit " + pageNo + ", " + pageSize);
            // sql.append(" limit " + pageNo + "," + pageSize);
        }
        ArrayList list = new ArrayList();
        Connection conn = null;
        try {
            conn = JDBCDataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                bean = new ProductBean();
                bean.setId(rs.getLong(1));
				bean.setCategoryId(rs.getLong(2));
				bean.setCategoryName(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setPrice(rs.getLong(5));
				bean.setDescription(rs.getString(6));
				bean.setImage(rs.getString(7));
				bean.setCreatedBy(rs.getString(8));
				bean.setModifiedBy(rs.getString(9));
				bean.setCreatedDatetime(rs.getTimestamp(10));
				bean.setModifiedDatetime(rs.getTimestamp(11));
                list.add(bean);
            }
            rs.close();
        } catch (Exception e) {
           log.error("Database Exception..", e);
            throw new ApplicationException(
                    "Exception : Exception in search Role");
        } finally {
            JDBCDataSource.closeConnection(conn);
        }
        log.debug("Model search End");
        return list;
    }
    
    public List list() throws ApplicationException {
        return list(0, 0);
    }

    /**
     * Get List of Role with pagination
     * 
     * @return list : List of Role
     * @param pageNo
     *            : Current Page No.
     * @param pageSize
     *            : Size of Page
     * @throws DatabaseException
     *  @throws ApplicationException
     */
    public List list(int pageNo, int pageSize) throws ApplicationException {
        log.debug("Model list Started");
        ArrayList list = new ArrayList();
        StringBuffer sql = new StringBuffer("select * from s_Product");
        // if page size is greater than zero then apply pagination
        if (pageSize > 0) {
            // Calculate start record index
            pageNo = (pageNo - 1) * pageSize;
            sql.append(" limit " + pageNo + "," + pageSize);
        }
        Connection conn = null;
        try {
            conn = JDBCDataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean bean = new ProductBean();
                bean.setId(rs.getLong(1));
				bean.setCategoryId(rs.getLong(2));
				bean.setCategoryName(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setPrice(rs.getLong(5));
				bean.setDescription(rs.getString(6));
				bean.setImage(rs.getString(7));
				bean.setCreatedBy(rs.getString(8));
				bean.setModifiedBy(rs.getString(9));
				bean.setCreatedDatetime(rs.getTimestamp(10));
				bean.setModifiedDatetime(rs.getTimestamp(11));
                list.add(bean);
            }
            rs.close();
        } catch (Exception e) {
          //  log.error("Database Exception..", e);
            throw new ApplicationException(
                    "Exception : Exception in getting list of Role");
        } finally {
            JDBCDataSource.closeConnection(conn);
        }
        log.debug("Model list End");
        return list;

    }

}
