package jdbcproject;
import java.util.Scanner;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.InputMismatchException;


public class CECS323TermProject {
   
     //  Database credentials
    static String USER;
    static String PASS;
    static String DBNAME;
    static final String displayFormat="%-25s%-25s%-15s%-15s\n";
    static final String displayFormat2="%-40s%-55s%-40s%-15s\n";
    static final String displayFormat3="%-25s%-25s%-40s%-15s%-15s\n";
// JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.apache.derby.jdbc.ClientDriver";
    static String DB_URL = "jdbc:derby://localhost:1527/";
//            + "testdb;user=";

    public static void main(String []args){
        
        ArrayList<String> writingGr = new ArrayList<String>();
        writingGr.add("groupName");
        writingGr.add("headWriter");
        writingGr.add("yearFormed");
        writingGr.add("subject");
        
        ArrayList<String> publisherInfo = new ArrayList<String>();
        publisherInfo.add("publisherName");
        publisherInfo.add("publisherAddress");
        publisherInfo.add("publisherPhone");
        publisherInfo.add("publisherEmail");
        
        //Prompt the user for the database name, and the credentials.
        //If your database has no credentials, you can update this code to 
        //remove that from the connection string.
        Scanner in = new Scanner(System.in);
        System.out.print("Name of the database (not the user account): ");
        DBNAME = in.nextLine();
        System.out.print("Database user name: ");
        USER = in.nextLine();
        System.out.print("Database password: ");
        PASS = in.nextLine();
        //Constructing the database URL connection string
        DB_URL = DB_URL + DBNAME + ";user="+ USER + ";password=" + PASS;
        String displayFormat2="%-40s%-55s%-40s%-15s\n";
        
        int menuSelection = 0;
        do{ //Display menu of options to user
            menuSelection = 0;
            System.out.println();
            System.out.println("1) List all writing groups");
            System.out.println("2) List all the data for a group specified by the user");
            System.out.println("3) List all the publishers");
            System.out.println("4) List all the data for a publisher specified by the user");
            System.out.println("5) List all book titles");
            System.out.println("6) List all the data for a book specified by the user");
            System.out.println("7) Insert a new book");
            System.out.println("8) Insert a new publisher and update all books by one publisher to "
                    + "be published by the new publisher");
            System.out.println("9) Remove a book specified by the user");
            System.out.println("10) Exit program");
            System.out.println("");
            
            do{
                try{
                    menuSelection = in.nextInt();
                }catch(InputMismatchException e){
                    System.out.println("Invalid entry, enter an integer selection between 1-10");
                }
                if(menuSelection<1 || menuSelection>10){
                    System.out.println("Invalid entry, enter an integer selection between 1-10");
                }
                in.nextLine();
            } while(menuSelection<1 || menuSelection>10);
                   
            
            switch(menuSelection){
                case 1: //displays all writing groups
                    displayGroupsOrPublishers(writingGr, "WritingGroup",displayFormat);   
                    break;
                case 2://lists all data of a certain writing group
                    selectCertainWritingGroupOrPublisher(writingGr, "WritingGroup",displayFormat);
                    break;
                case 3: //displays all publishers
                    displayGroupsOrPublishers(publisherInfo, "Publisher", displayFormat2);
                    break;
                case 4://lists all data of a certain publisher
                    selectCertainWritingGroupOrPublisher(publisherInfo, "Publisher", displayFormat2);
                    break;
                case 5://displays all books
                    displayBooks();
                    break;
                case 6://lists the data for a book specified by the user
                    selectCertainBook();
                    break;
                case 7:
                    insertBook();
                    break;
                case 8:
                    insertAndUpdatePublisher();
                    break;
                case 9:
                    deleteBook();
                    break;
                case 10:
                    break;
            }
            
        }while(menuSelection !=10);
    }
    
    /**
 * Takes the input string and outputs "N/A" if the string is empty or null.
 * @param input The string to be mapped.
 * @return  Either the input string or "N/A" as appropriate.
 */
    public static String dispNull (String input) {
        //because of short circuiting, if it's null, it never checks the length.
        if (input == null || input.length() == 0)
            return "N/A";
        else
            return input;
    }
  
    //This method displays all book titles
    public static void displayBooks(){
        Connection conn = null; //initialize the connection

        try {
            //STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            //STEP 3: Open a connection
            conn = DriverManager.getConnection(DB_URL);
            PreparedStatement ultimateStatement = conn.prepareStatement("SELECT* FROM Book");
            ResultSet rs = ultimateStatement.executeQuery();

            //STEP 5: Extract data from result set
            System.out.printf(displayFormat3, "groupName", "bookTitle", "publisherName", "yearPublished", "numberOfPages");
            while (rs.next()) {
                //Retrieve by column name
                String groupName = rs.getString("groupName");
                String head = rs.getString("bookTitle");
                String first = rs.getString("publisherName");
                String last = rs.getString("yearPublished");
                String whatever = rs.getString("numberPages");

                //Display values
                System.out.printf(displayFormat3, 
                        dispNull(groupName), dispNull(head), dispNull(first), dispNull(last), dispNull(whatever));
            }
            //STEP 6: Clean-up environment
            rs.close();
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }
    
    //This method retrieves all data for all writing groups or publishers based on user's choice
    public static void displayGroupsOrPublishers(ArrayList<String> alist, String choice, String format){
        Connection conn = null; //initialize the connection
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL);
            
            ResultSet rs;
            PreparedStatement ultimateStatement;
            //determine which data to show, writing groups or publishers
            if(choice.equals("WritingGroup")){
                ultimateStatement = conn.prepareStatement("SELECT* FROM WritingGroup");   
            }
            else{
                 ultimateStatement = conn.prepareStatement("SELECT* FROM Publisher");
            }
            rs = ultimateStatement.executeQuery();
          

            //STEP 5: Extract data from result set
            System.out.printf(format, alist.get(0), alist.get(1),alist.get(2), alist.get(3));
            while (rs.next()) {
                //Retrieve by column name
                String groupName = rs.getString(alist.get(0));
                String head = rs.getString(alist.get(1));
                String first = rs.getString(alist.get(2));
                String last = rs.getString(alist.get(3));

                //Display values
                System.out.printf(format, 
                        dispNull(groupName), dispNull(head), dispNull(first), dispNull(last));
            }
            //STEP 6: Clean-up environment
            rs.close();
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }
   
    
    //This method displays a selected writing group or publisher's information...
    public static void selectCertainWritingGroupOrPublisher(ArrayList<String> datList,String userChoice, String format){
        Scanner in = new Scanner(System.in);    
        Connection conn = null; //initialize the connection
        try {
            //STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            boolean flagging = false;
            //STEP 3: Open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL);
            
            PreparedStatement daStatement = null;
            String entryWritingGroup="";
            String entryPublisher = "";
           
            
            while(!flagging){
                if(userChoice.equals("WritingGroup")){
                    PreparedStatement isTableEmpty = conn.prepareStatement("SELECT * from WritingGroup");
                    ResultSet resultingSet = isTableEmpty.executeQuery();
                    boolean userCanLeave = false;
                    while(resultingSet.next()){
                        userCanLeave = true;
                    }
                    if(!userCanLeave){
                        break;
                    }
                    boolean active = false;
                    do{
                        System.out.println("Enter a writing group in order to retrieve its entire data");
                        entryWritingGroup = in.nextLine();
                        daStatement = conn.prepareStatement("SELECT groupName, headWriter, yearFormed, subject FROM WritingGroup WHERE groupName = ?");
                        daStatement.setString(1, entryWritingGroup);
                        ResultSet groupInfo = daStatement.executeQuery();
                        while(groupInfo.next()){
                            active = true;
                        }
                        if(!active){
                            System.out.println("This writing group doesn't exist");
                        }
                    
                    }while(!active);
                
                }
                //else, select a publisher to display its data
                else{
                    //checks if table of publishers is empty
                    PreparedStatement isTableEmpty2 = conn.prepareStatement("SELECT * from Publisher");
                    ResultSet resultingSet2 = isTableEmpty2.executeQuery();
                    boolean userCanLeave2 = false;
                    while(resultingSet2.next()){
                        userCanLeave2 = true;
                    }
                    if(!userCanLeave2){
                        break;
                    }
                    //everything is good, now validates user entry for a publisher in the publishers table
                    boolean active2 = false;
                    do{
                        System.out.println("Enter a publisher in order to retrieve its entire data");
                        entryPublisher = in.nextLine();
                        daStatement = conn.prepareStatement("SELECT* FROM Publisher WHERE publisherName = ?");
                        daStatement.setString(1, entryPublisher);
                        ResultSet publishInfo = daStatement.executeQuery();
                        while(publishInfo.next()){
                            active2 = true;
                        }
                        if(!active2){
                            System.out.println("This publisher doesn't exist");
                        }
                    }while(!active2);
                }
                flagging = true;
            }

            ResultSet rs = daStatement.executeQuery();
            System.out.printf(format, datList.get(0), datList.get(1), datList.get(2), datList.get(3));

            boolean flag1 = false;
            while (rs.next()) {
                flag1 = true;
                String groupName = rs.getString(datList.get(0));
                String head = rs.getString(datList.get(1));
                String first = rs.getString(datList.get(2));
                String last = rs.getString(datList.get(3));

                //Display values
                System.out.printf(format, 
                        dispNull(groupName), dispNull(head), dispNull(first), dispNull(last));
            }
            if(!flag1){
                System.out.println("No " + userChoice  + " with that name has been found");
            }
            //STEP 6: Clean-up environment
            rs.close();
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }
    
    //This method selects a certain book and displays its criteria
    public static void selectCertainBook(){
        Scanner in = new Scanner(System.in);
        
        Connection conn = null; //initialize the connection
        try {
            //STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            //STEP 3: Open a connection
            PreparedStatement secondOne = null;
            conn = DriverManager.getConnection(DB_URL);
            String entryWritingGroup="";
            String entryPublisher = "";
            ResultSet temp;
            boolean flagging=false;
            do{
                System.out.println("Enter a writing group for that book");
                entryWritingGroup = in.nextLine();
                secondOne = conn.prepareStatement("SELECT * FROM WritingGroup where groupName = ?");
                secondOne.setString(1, entryWritingGroup);
                temp = secondOne.executeQuery();
                flagging = false;
                while(temp.next()){
                    flagging = true;
                }
                if(!flagging){
                    System.out.println("Incorrect entry or writing group not found, enter writing group once again");
                }
                
            }while(!flagging);
            PreparedStatement daStatement;
            
            String entryBookTitle = "";
           
            System.out.println("Enter a book in order to retrieve its entire data");
                entryBookTitle = in.nextLine();
                daStatement = conn.prepareStatement("SELECT* FROM Book NATURAL JOIN Publisher NATURAL JOIN WritingGroup WHERE groupName = ? AND bookTitle = ?");
               
                daStatement.setString(1, entryWritingGroup);
                daStatement.setString(2, entryBookTitle);
               

            ResultSet rs = daStatement.executeQuery();
            
            //STEP 5: Extract data from result set
            String displayFormat2="%-25s%-25s%-15s%-15s%-25s%-25s%-25s%-25s\n";
            System.out.printf(displayFormat2, "groupName", "headWriter", "yearFormed", "subject", "bookTitle", "publisherName", "yearPublished", "numberPages");
            boolean flag1 = false;
            while (rs.next()) {
                flag1 = true;
                String bookGroupName = rs.getString("groupName");
                String headWriter = rs.getString("headWriter");
                String yearFormed = rs.getString("yearFormed");
                String subject = rs.getString("subject");
                String bookTitleName = rs.getString("bookTitle");
                String bookPublisherName = rs.getString("publisherName");
                String bookYearPublished = rs.getString("yearPublished");
                String bookNumberPages = rs.getString("numberPages");

                //Display values
                System.out.printf(displayFormat2, 
                        dispNull(bookGroupName), dispNull(headWriter), dispNull(yearFormed),dispNull(subject), dispNull(bookTitleName), dispNull(bookPublisherName), dispNull(bookYearPublished), dispNull(bookNumberPages));
            }
            if(!flag1){
                System.out.println("Unfortunately, there is no book by that name");
            }
            //STEP 6: Clean-up environment
            rs.close();
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
        
    }
    
    
    
    
       //This method inserts a new book
public static void insertBook(){
    Scanner in = new Scanner(System.in);
    Connection conn = null; //initialize the connection
    PreparedStatement pstmt = null; //initialize the statement that we're using
    try{
        //STEP 2: Register JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver"); 
        //STEP 3: Open a connection
        conn = DriverManager.getConnection(DB_URL);
        
        String entryBookTitle = null;
        String entryGroupName = null;
        boolean unique;
        do{
            System.out.println("Enter a book title to insert");
            entryBookTitle = in.nextLine();
            
            boolean existingWritingGroup;
            do{
                System.out.println("Enter the writing group's name");
                entryGroupName = in.nextLine();
                
                String sqlCheck = "SELECT groupName, headWriter, yearFormed, subject FROM writingGroup WHERE groupName = ?";
                PreparedStatement uniqueCheck = conn.prepareStatement(sqlCheck);
                uniqueCheck.setString(1, entryGroupName);
                ResultSet uniqueGroup = uniqueCheck.executeQuery();
                
                if(!uniqueGroup.next()){
                    existingWritingGroup = false;
                    System.out.println("That writing group doesn't exist !");
                }else{
                    existingWritingGroup = true;
                }
                
            }while(!existingWritingGroup);
            
            String sqlCheck = "SELECT groupName, bookTitle, publisherName, yearPublished, numberPages FROM Book WHERE bookTitle = ? AND groupName = ?";
            PreparedStatement uniqueCheck = conn.prepareStatement(sqlCheck);
            uniqueCheck.setString(1, entryBookTitle);
            uniqueCheck.setString(2, entryGroupName);
            ResultSet uniqueBook = uniqueCheck.executeQuery();
            
            if(!uniqueBook.next()){
                unique = true;
            }else{
                unique = false;
                System.out.println("That book already exists!");
            }
        } while(!unique);
        
        
        boolean existingPublisher;
        String entryPublisherName = null;
        do{
            System.out.println("Enter the publisher's name");
            entryPublisherName = in.nextLine();
            String sqlCheck = "SELECT publisherName, publisherAddress, publisherPhone, publisherEmail FROM publisher WHERE publisherName = ?";
            PreparedStatement uniqueCheck = conn.prepareStatement(sqlCheck);
            uniqueCheck.setString(1, entryPublisherName);
            ResultSet uniqueResult = uniqueCheck.executeQuery();
            if(!uniqueResult.next()){
                existingPublisher = false;
                System.out.println("That publisher doesn't exist!");
            }else{
                existingPublisher = true;
            }
        }while(!existingPublisher);
        
        
        String promptPublisher = "Enter the year published";
        int entryYearPublished = userIntegerValidation(promptPublisher);
        
        
        in.nextLine();
        
       
        int numOfPages = 0;
        do{
            System.out.println("Enter the number of pages");
            try{
                numOfPages = in.nextInt();
            }catch(InputMismatchException e){
                System.out.println("Invalid entry, enter an integer greater than 1");
            }
            if(numOfPages<1){
                System.out.println("Invalid entry, enter an integer greater than 1");
            }
               in.nextLine();
        } while(numOfPages<1);
        
        String entryNumberPages = Integer.toString(numOfPages);
        
        //inserting specified book into the book table
        String sqlState = "INSERT INTO book(groupName, bookTitle, publisherName,yearPublished, numberPages) VALUES(?,?,?,?,?)";
        pstmt = conn.prepareStatement(sqlState);
        pstmt.setString(1, entryGroupName);
        pstmt.setString(2, entryBookTitle);
        pstmt.setString(3, entryPublisherName);
        pstmt.setInt(4, entryYearPublished);
        pstmt.setString(5, entryNumberPages);
        pstmt.executeUpdate();
        
        System.out.println("");
        System.out.println(entryBookTitle + " by " + entryGroupName + " has been inserted.");
        
        PreparedStatement secondaryStatement = conn.prepareStatement("SELECT * FROM Book");
        ResultSet rs = secondaryStatement.executeQuery();
        
        System.out.printf(displayFormat3, "groupName", "bookTitle", 
"publisherName", "yearPublished", "numberPages" );
        boolean flag1 = false;
        while (rs.next()) {
            flag1 = true;
            String groupName = rs.getString("groupName");
            String title = rs.getString("bookTitle");
            String publisher = rs.getString("publisherName");
            int year = rs.getInt("yearPublished");
            String pages = rs.getString("numberPages");
            //Display values
            System.out.printf(displayFormat3, 
                    dispNull(groupName), dispNull(title), dispNull(publisher), 
dispNull(Integer.toString(year)), dispNull(pages));
        }
        
        if(!flag1){
            System.out.println("There are no books in the database");
        }
        //STEP 6: Clean-up environment
        pstmt.close();
        conn.close();            
    }catch (SQLException se) {
        //Handle errors for JDBC
        se.printStackTrace();
    } catch (Exception e) {
        //Handle errors for Class.forName
        e.printStackTrace();
    } finally {
        //finally block used to close resources
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException se2) {
        }// nothing we can do
        try {
            if (conn != null) {
                conn.close();
            }
        }catch(SQLException se){
            se.printStackTrace();
        }
    }
}
     

    //This method deletes a book at the user's expense
    public static void deleteBook(){
        Scanner in = new Scanner(System.in);
        Connection conn = null; //initialize the connection
        PreparedStatement pstmt = null;
        PreparedStatement secondOne = null;
        try {
            //STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL);
            String entryWritingGroup = "";
            ResultSet temp;
            boolean flagging=false;
            do{
                System.out.println("Enter a writing group");
                entryWritingGroup = in.nextLine();
                secondOne = conn.prepareStatement("SELECT * FROM WritingGroup where groupName = ?");
                secondOne.setString(1, entryWritingGroup);
                temp = secondOne.executeQuery();
                flagging = false;
                while(temp.next()){
                    flagging = true;
                }
                if(!flagging){
                    System.out.println("Incorrect entry or writing group not found, enter writing group once again");
                }
                
            }while(!flagging);
            
            
            
            System.out.println("Enter a book title to delete that book");
            String entryBookTitle = in.nextLine();
            String sqlState = "DELETE FROM Book WHERE bookTitle = ? AND groupName = ?";
            pstmt = conn.prepareStatement(sqlState);
            pstmt.setString(1, entryBookTitle);
            pstmt.setString(2, entryWritingGroup);
            int rs2 = pstmt.executeUpdate();
            System.out.println();
            
            if(rs2 == 0){
                System.out.println("No book with that writing group was found, attempt to delete has failed");
                
            }
            else{
                System.out.println("The specified book has been removed");
            }
            System.out.println();
            
            PreparedStatement secondaryStatement = conn.prepareStatement("SELECT * FROM Book");
            ResultSet rs = secondaryStatement.executeQuery();
            
                    
            
            //STEP 5: Extract data from result set
            System.out.printf(displayFormat3, "groupName", "bookTitle", "publisherName", "yearPublished", "numberPages" );
            boolean flag1 = false;
            while (rs.next()) {
                flag1 = true;
                String groupName = rs.getString("groupName");
                String head = rs.getString("bookTitle");
                String first = rs.getString("publisherName");
                String last = rs.getString("yearPublished");
                String abercrombie = rs.getString("numberPages");

                //Display values
                System.out.printf(displayFormat3, 
                        dispNull(groupName), dispNull(head), dispNull(first), dispNull(last), dispNull(abercrombie));
            }
            //STEP 6: Clean-up environment
            rs.close();
    
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if(pstmt != null){
                    pstmt.close();
                }
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }
    
    //This method inserts a new publisher and updates all books' old publisher info with the new info
    public static void insertAndUpdatePublisher(){
        Scanner in = new Scanner(System.in);
        Connection conn = null; //initialize the connection
        Statement stmt = null;  //initialize the statement that we're using
        PreparedStatement pstmt = null;
        try {
            //STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL);
            String entryNewPublisherName = "";
            String entryNewPublisherAddress = "";
            String entryNewPublisherPhone = "";
            String entryNewPublisherEmail = "";
            PreparedStatement ultimateState = null;
            
            PreparedStatement validatePublisherName = null;
            boolean active = false;
            do{
                System.out.println("Enter a new publisher name");
                entryNewPublisherName = in.nextLine();
                while(entryNewPublisherName.equals("null") || entryNewPublisherName.equals("")){
                    System.out.println("Publisher name cannot be empty");
                    System.out.println("Enter a new publisher name");
                    entryNewPublisherName = in.nextLine();
                }
                validatePublisherName = conn.prepareStatement("SELECT publisherName from publisher WHERE publisherName = ?");
                validatePublisherName.setString(1,entryNewPublisherName);
                ResultSet rsTemp = validatePublisherName.executeQuery();
                
                //if resultset contains at least some data, then ask for publisher name again
                if(rsTemp.next()){
                    active = true;
                    System.out.println("Oh no publisher already exists in table");
                }
                else{
                    active = false;
                }
                
            } while(active);
            
           
            System.out.println("Enter publisher address");
            entryNewPublisherAddress = in.nextLine();
          
            
            System.out.println("Enter publisher phone");
            entryNewPublisherPhone = in.nextLine();
            
            System.out.println("Enter publisher email");
            entryNewPublisherEmail = in.nextLine();
    
           
            ultimateState = conn.prepareStatement("INSERT INTO Publisher(publisherName, publisherAddress, publisherPhone, publisherEmail) values(?, ?, ?, ?)");
            ultimateState.setString(1,entryNewPublisherName);
            ultimateState.setString(2,entryNewPublisherAddress);
            ultimateState.setString(3, entryNewPublisherPhone);
            ultimateState.setString(4, entryNewPublisherEmail);
            int insertionAdd = ultimateState.executeUpdate();
            
            System.out.println("New publisher has been added to the publisher table");
            String entryOldPublisher = "";
            PreparedStatement auxiliary = null;
            
            
            PreparedStatement secondaryStatement = conn.prepareStatement("SELECT * FROM publisher");
            ResultSet rs2 = secondaryStatement.executeQuery();
            System.out.printf(displayFormat2, "publisherName", "publisherAddress", "publisherPhone", "publisherEmail", "");
            boolean flag1 = false;
            while (rs2.next()) {
                flag1 = true;
                String publisherName = rs2.getString("publisherName");
                String publisherAddress = rs2.getString("publisherAddress");
                String publisherPhone = rs2.getString("publisherPhone");
                String publisherEmail = rs2.getString("publisherEmail");
                
                //Display values
                System.out.printf(displayFormat2, 
                        dispNull(publisherName), dispNull(publisherAddress), dispNull(publisherPhone), dispNull(publisherEmail), "");
            }
            if(!flag1){
                System.out.println("There are no publishers in the database");
            }
            
            System.out.println();
            
            boolean check = false;
            do{
                System.out.println("Enter a publisher name that is sought to be replaced for the books published");
                entryOldPublisher = in.nextLine();
                auxiliary = conn.prepareStatement("SELECT publisherName from book WHERE publisherName = ?");
                auxiliary.setString(1,entryOldPublisher);
                ResultSet tempSet = auxiliary.executeQuery();
                while(tempSet.next()){
                    check = true;
                }
                if(!check){
                    System.out.println("Publisher name hasn't been found in the books table, enter again");
                }
            }while(!check);
            
            PreparedStatement updateBook = conn.prepareStatement("UPDATE book SET book.publisherName = ? WHERE book.publisherName = ?");
            updateBook.setString(1, entryNewPublisherName);
            updateBook.setString(2,entryOldPublisher);
            int c = updateBook.executeUpdate();

            
            PreparedStatement showBooksWithCertainPub = conn.prepareStatement("SELECT * from Book where publisherName = ?");
            showBooksWithCertainPub.setString(1, entryNewPublisherName);
            ResultSet rs1 = showBooksWithCertainPub.executeQuery();

            System.out.println("UPDATES WERE SUCCESSFUL");
            
            System.out.println();
            System.out.printf(displayFormat2, "groupName", "bookTitle", "publisherName", "yearPublished", "numberPages" );
            boolean active2 = false;
            while(rs1.next()){
                active2 = true;
                String groupN = rs1.getString("groupName");
                String title = rs1.getString("bookTitle");
                String publishName = rs1.getString("publisherName");
                String yearPub = rs1.getString("yearPublished");
                String numberPages = rs1.getString("numberPages");
                System.out.printf(displayFormat2, dispNull(groupN), dispNull(title), dispNull(publishName), dispNull(yearPub), dispNull(numberPages) );
                if(!active2){
                    System.out.println("There are no books in the database by that publisher");
                }
            }
            conn.close();
            
            
            
            
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
                
                if(pstmt != null){
                    pstmt.close();
                }
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }
    
    //This method validates user integer validation for the year published
    public static int userIntegerValidation(String promptMessage){
        Scanner in = new Scanner(System.in);
        int fixedInteger = 0;
        do{
            System.out.println(promptMessage);
            try{
                fixedInteger = in.nextInt();
            }catch(InputMismatchException e){
                System.out.println("Invalid entry, enter an integer selection between 1-2017");
            }
            if(fixedInteger<1 || fixedInteger>2017){
                System.out.println("Invalid entry, enter an integer selection between 1-2017");
            }
               in.nextLine();
        } while(fixedInteger<1 || fixedInteger>2017);
        
        return fixedInteger;
    }
}
