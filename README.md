# Software Access Management System

This project is a web-based system for managing software access requests. It allows users to register, log in, request access to software, and manage those requests. The system is designed with different roles: Employees, Managers, and Admins, each with specific access and permissions.

## Features

- **Employee**:
  - Can register and log in.
  - Can request access to various software applications.
  - Can view and submit requests for software access.

- **Manager**:
  - Can log in and view pending access requests from Employees.
  - Can approve or reject access requests based on their role and requirements.

- **Admin**:
  - Can log in and add new software applications to the system.
  - Can assign access levels (Read, Write, Admin) for each software.

- **User Logout**:
  - Users can log out of the system, which invalidates their session and redirects them to the login page.

## Technologies Used

- **Frontend**: HTML, JSP, CSS, JavaScript
- **Backend**: Java (Servlets, JDBC)
- **Database**: MySQL

## Getting Started

### Prerequisites

- JDK 8 or higher
- Apache Tomcat server
- MySQL database

### Setup Instructions

1. **Clone the repository**:
    ```bash
    git clone <repository-url>
    ```

2. **Set up the MySQL database**:
    - Create a database named `software_access_management`.
    - Create the following tables based on the provided SQL schema:
      - `users`
      - `software`
      - `requests`
    
3. **Configure the database connection**:
    - Update the database connection settings in the project (typically in a `db.properties` file or similar).

4. **Deploy on Apache Tomcat**:
    - Import the project into your IDE (e.g., Eclipse, IntelliJ).
    - Deploy the web application on Apache Tomcat server.

5. **Run the application**:
    - Open a browser and go to `http://localhost:8080/<your-project-name>/signup.jsp` to start the application.

## Demo Video

You can watch a demo of the project here:  
[**Project Demo**](https://youtu.be/bN96RyiS3hs)

## Features Walkthrough

1. **User Registration**:  
   The user can register by providing a username and password. After successful registration, the user will be redirected to the login page.

2. **Login**:  
   Registered users can log in. Based on their role, they will be redirected to different pages:
   - **Employee**: Access Request Page (`requestAccess.jsp`).
   - **Manager**: Pending Requests Page (`pendingRequests.jsp`).
   - **Admin**: Software Creation Page (`createSoftware.jsp`).

3. **Request Access**:  
   Employees can submit requests to access software by selecting the software name, access type, and providing a reason for the request.

4. **Manager Approval**:  
   Managers can view pending requests and approve or reject them.

5. **Admin Software Management**:  
   Admins can create new software entries, specifying access levels (Read, Write, Admin) for each.

6. **Logout**:  
   Users can log out, which will invalidate their session and redirect them to the login page.

## Folder Structure

