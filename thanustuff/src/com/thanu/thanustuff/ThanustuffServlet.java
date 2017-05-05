package com.thanu.thanustuff;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;

@SuppressWarnings("serial")
public class ThanustuffServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		doPost(req, resp);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		HttpSession session = req.getSession();
		String responseMessage = "sampleMessage";
		DatastoreService dslogin = DatastoreServiceFactory
				.getDatastoreService();
		PreparedQuery pqlogin = null;
		if (req.getParameter("userName") != null
				&& req.getParameter("password") != null) {
			// System.out.println(" i am in loggin action");
			String userName = req.getParameter("userName");
			String password = req.getParameter("password");

			Query listuser = new Query("User").addFilter("userName",
					FilterOperator.EQUAL, userName);
			pqlogin = dslogin.prepare(listuser);
			Boolean userFound = false;
			for (Entity e : pqlogin.asIterable()) {
				userFound = true;
				String dbpassword = e.getProperty("password").toString();
				String role = e.getProperty("role").toString();
				if (dbpassword.equals(password)) {
					responseMessage = "login success";
					session.setAttribute("userName", userName);
					session.setAttribute("userRole", role);

				} else {
					responseMessage = "password doesn't match";
				}

			}

			if (!userFound) {
				responseMessage = "User name not found";
			}

		}

		else if (req.getParameter("adduserName") != null
				&& req.getParameter("password") != null
				&& req.getParameter("role") != null) {
			String userName = req.getParameter("adduserName");
			String password = req.getParameter("password");
			String role = req.getParameter("role");

			Query listuser = new Query("User").addFilter("userName",
					FilterOperator.EQUAL, userName);
			pqlogin = dslogin.prepare(listuser);
			Boolean userFound = false;
			for (Entity e : pqlogin.asIterable()) {
				userFound = true;
			}

			if (userFound) {
				responseMessage = "User name already exists";
			} else {
				Entity e1 = new Entity("User");
				e1.setProperty("userName", userName);
				e1.setProperty("password", password);
				e1.setProperty("role", role);
				dslogin.put(e1);
				responseMessage = "User added successfully";
			}

		} else if (req.getParameter("removeuserName") != null) {

			String userName = req.getParameter("removeuserName").toString();
			Query listuser = new Query("User").addFilter("userName",
					FilterOperator.EQUAL, userName);
			pqlogin = dslogin.prepare(listuser);
			Boolean userFound = false;
			for (Entity e : pqlogin.asIterable()) {
				userFound = true;
				Long idNum = e.getKey().getId();
				dslogin.delete(KeyFactory.createKey("User", idNum));
				responseMessage = "User has been removed successfully";
			}

			if (!userFound) {
				responseMessage = "User not found";
			}

		}
		
		else if (req.getParameter("newpassword") != null &&
				 req.getParameter("userName")!= null) {

			String password = req.getParameter("newpassword").toString();
			String userName = req.getParameter("userName").toString();
			
			Query listuser = new Query("User").addFilter("userName",
					FilterOperator.EQUAL, userName);
			pqlogin = dslogin.prepare(listuser);
			Boolean userFound = false;
			for (Entity e : pqlogin.asIterable()) {
				userFound = true;
				e.setProperty("userName", userName);
				e.setProperty("password", password);
				dslogin.put(e);
				
			}

			if (userFound) {
				responseMessage = "Password has been changed successfully";
			}
			else 
				responseMessage = "User not found";

		}

		resp.getWriter().println(responseMessage);
	}
}
