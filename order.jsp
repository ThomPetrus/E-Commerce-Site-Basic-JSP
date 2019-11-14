<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

	<%
		// Get customer id
		String custId = request.getParameter("customerId");
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		// login info
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_tvande;";
		String uid = "tvande";
		String pw = "33970138";
		
		// Determine if valid customer id was entered
		// Determine if there are products in the shopping cart
		// If either are not true, display an error message

		boolean isValid = true;

		try {
			Integer.parseInt(custId);
		} catch (NumberFormatException e) {
			isValid = false;
		} catch (NullPointerException e) {
			isValid = false;
		} catch (Exception e) {
			isValid = false;
		}

		if (productList != null && productList.isEmpty()) {
			out.print("<h1>Your Cart is Empty!</h1>");
		} else if (!isValid) {
			out.print("<h1>Invalid Customer Id</h1>");
			out.print("<p>Go back to the previous page and try again.</p>");
		} else {

			try (Connection con = DriverManager.getConnection(url, uid, pw)) {
				String SQL = "SELECT customerId FROM Customer WHERE customerId =" + custId;
				PreparedStatement pstmt = con.prepareStatement(SQL);
				ResultSet rst = pstmt.executeQuery();
				
				if (!rst.next()) {
					out.print("<h1>Invalid Customer Id</h1>");
					out.print("<p>Go back to the previous page and try again.</p>");
				} else {
				
					pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
					ResultSet keys = pstmt.getGeneratedKeys();
					keys.next();
					int orderId = keys.getInt(1);
					
					
					
					
				}
			} catch (SQLException e) {
				System.err.println(e);
			}
		}

		// Make connection

		// Save order information to database

		/*
		// Use retrieval of auto-generated keys.
		PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		*/

		// Insert each item into OrderProduct table using OrderId from previous INSERT

		// Update total amount for order record

		// Here is the code to traverse through a HashMap
		// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

		/*
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
		String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
		...
			}
		*/

		// Print out order summary

		// Clear cart if order placed successfully
	%>
</BODY>
</HTML>
