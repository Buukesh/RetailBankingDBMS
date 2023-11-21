import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;

public class RetailBankingSystem extends JFrame {
    private static final String DB_URL = "jdbc:oracle:thin:@oracle.scs.ryerson.ca:1521:orcl";
    private static final String USERNAME = "a4ahuja";
    private static final String PASSWORD = "02077430";
    private static final String UPDATE_BALANCE_QUERY = "UPDATE accounts SET balance = ? WHERE id = ?";
    private static final String DELETE_ACCOUNT_QUERY = "DELETE FROM accounts WHERE id = ?";
    private static JTextArea outputArea;
    public RetailBankingSystem() {
        super("Retail Banking System");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 400);
        setLocationRelativeTo(null);

        // Create components
        JButton createTablesButton = new JButton("Create Tables");
        JButton dropTablesButton = new JButton("Drop Tables");
        JButton populateTablesButton = new JButton("Populate Tables");
        JButton queryTablesButton = new JButton("Query Tables");
        JButton updateRecordButton = new JButton("Update Record");
        JButton deleteRecordButton = new JButton("Delete Record");
        JButton searchButton = new JButton("Search Record");
        JButton clearButton = new JButton("Clear Screen");

        outputArea = new JTextArea(15, 40);
        outputArea.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(outputArea);

        // Set layout
        setLayout(new BorderLayout());

        // Add components to the frame
        JPanel buttonPanel = new JPanel();
        buttonPanel.add(createTablesButton);
        buttonPanel.add(dropTablesButton);
        buttonPanel.add(populateTablesButton);
        buttonPanel.add(queryTablesButton);
        buttonPanel.add(updateRecordButton);
        buttonPanel.add(deleteRecordButton);
        buttonPanel.add(searchButton);
        buttonPanel.add(clearButton);

        add(buttonPanel, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);

        // Add action listeners
        createTablesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                createTables();
            }
        });

        dropTablesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dropTables();
            }
        });

        populateTablesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                populateTables();
            }
        });

        queryTablesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                queryTables();
            }
        });

        updateRecordButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                updateRecord();
            }
        });

        deleteRecordButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                deleteRecord();
            }
        });

        searchButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                searchRecords();
            }
        });

        clearButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) { outputArea.setText("");}
        });
    }

    private void createTables() {
        try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
            String sqlFilePath = "/Users/anishahuja/IdeaProjects/RetailBankingDBMS/src/FN3 Tables.sql";
            executeSQLFromFile(connection, sqlFilePath);
            outputArea.append("Tables created successfully.\n");
        } catch (SQLException e) {
            e.printStackTrace();
            outputArea.append("Error creating tables.\n");
        }
    }

    private void dropTables(){
        try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
            String sqlFilePath = "/Users/anishahuja/IdeaProjects/RetailBankingDBMS/src/FN3 Drop.sql";
            executeSQLFromFile(connection, sqlFilePath);
            outputArea.append("Tables dropped successfully.\n");
        } catch (SQLException e) {
            e.printStackTrace();
            outputArea.append("Error dropping tables.\n");
        }
    }

    private void populateTables() {
        try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
            String sqlFilePath = "/Users/anishahuja/IdeaProjects/RetailBankingDBMS/src/FN3 Inserts.sql";
            executeSQLFromFile(connection, sqlFilePath);
            outputArea.append("Tables populated successfully.\n");
        } catch (SQLException e) {
            e.printStackTrace();
            outputArea.append("Error populating tables.\n");
        }
    }

    private void queryTables() {
        try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
             String sqlFilePath = "/Users/anishahuja/IdeaProjects/RetailBankingDBMS/src/FN3 Queries.sql";
             executeSQLFromFile(connection, sqlFilePath);
            outputArea.append("Tables queried successfully.\n");
        } catch (SQLException e) {
            e.printStackTrace();
            outputArea.append("Error querying tables.\n");
        }
    }

    public void updateRecord() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            String tableName = JOptionPane.showInputDialog(this, "Enter the table name you would like to update:");
            String columnName = JOptionPane.showInputDialog(this, "Enter the column name you would like to update:");
            String idName = JOptionPane.showInputDialog(this, "Enter the column name that represents the primary key:");
            String id = JOptionPane.showInputDialog(this, "Enter the primary key of the record to update:");
            String newValue = JOptionPane.showInputDialog(this, "Enter the new value:");

            // Construct the SQL query
            String query = "UPDATE " + tableName + " SET " + columnName + " = ? WHERE " + idName + " = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, newValue);
            preparedStatement.setString(2, id);

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Record updated successfully in table " + tableName + ".");
            } else {
                System.out.println("No record found for updating.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources in the reverse order of their creation
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteRecord() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            String tableName = JOptionPane.showInputDialog(this, "Enter the table name you would like to delete from:");
            String columnName = JOptionPane.showInputDialog(this, "Enter the column name you would like to use for deletion:");
            String id = JOptionPane.showInputDialog(this, "Enter the primary key of the record to delete:");

            // Construct the SQL query
            String query = "DELETE FROM " + tableName + " WHERE " + columnName + " = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, id);

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Record deleted successfully from table " + tableName + ".");
            } else {
                System.out.println("No record found for deletion.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources in the reverse order of their creation
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void searchRecords() {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            String tableName = JOptionPane.showInputDialog(this, "Enter the table name you would like to search for:");
            String columnName = JOptionPane.showInputDialog(this, "Enter the column name you would like to search for:");
            String id = JOptionPane.showInputDialog(this, "Enter the primary key of the record to search for:");

            // Construct the SQL query
            String query = "SELECT * FROM " + tableName + " WHERE " + columnName + " = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, id);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Print the query results using the existing function
            printQueryResults(resultSet);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void executeSQLFromFile(Connection connection, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath));
             Statement statement = connection.createStatement()) {

            StringBuilder sqlBuffer = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                // Ignore lines starting with "--" (comments)
                if (!line.trim().startsWith("--")) {
                    sqlBuffer.append(line);
//                     If the line ends with a semicolon, execute the statement

                        if (sqlBuffer.toString().trim().toLowerCase().startsWith("select")) {
                            ResultSet resultSet = statement.executeQuery(sqlBuffer.toString());
                            printQueryResults(resultSet);
                        } else {
                            System.out.println(sqlBuffer.toString().trim().toLowerCase().startsWith("select"));
                            System.out.println(sqlBuffer);
                            statement.executeUpdate(sqlBuffer.toString());
                        }
                        sqlBuffer.setLength(0);  // Clear the buffer

                }
            }
            System.out.println("SQL statements executed successfully.");

        } catch (IOException | SQLException e) {
            e.printStackTrace();
            System.err.println("Error executing SQL statements from file.");
        }
    }

    private static void printQueryResults(ResultSet resultSet) throws SQLException {
        // Append column labels to the outputArea
        ResultSetMetaData metaData = resultSet.getMetaData();
        System.out.println(metaData.toString());
        int columnCount = metaData.getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
            outputArea.append(metaData.getColumnName(i) + "\t");
        }
        outputArea.append("\n");

        // Iterate through the result set and append each row to the outputArea
        while (resultSet.next()) {
            for (int i = 1; i <= columnCount; i++) {
                outputArea.append(resultSet.getString(i) + "\t");
            }
            outputArea.append("\n");
        }

        // Add a newline for better readability
        outputArea.append("\n");
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new RetailBankingSystem().setVisible(true);
            }
        });
    }
}