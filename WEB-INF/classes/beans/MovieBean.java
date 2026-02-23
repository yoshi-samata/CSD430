package beans;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

    /*  
    Joshua Martin CSD430 Lab 6 - MovieBean.java - 02/08/2026
    Instructor: David Ostrowski
    What this Java bean does:
    connects to the CSD430 MySQL database, 
    pulls the list of movie_id values for the dropdown, 
    and fetches a single movie record by movie_id so the JSP pages can display it.
   */

public class MovieBean {

    // DB connection info lives here so JSP pages stay clean.
    private final String url = "jdbc:mysql://localhost:3306/csd430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private final String user = "student1";
    private final String pass = "pass";

    private Connection getConnection() throws Exception {
        // Load the MySQL driver once per connection.
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    // Get all movie_id values for a dropdown menu.
    public List<Integer> getAllMovieIds() throws Exception {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT movie_id FROM josh_movies_data ORDER BY movie_id";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ids.add(rs.getInt("movie_id"));
            }
        }
        return ids;
    }

    // Get one record by key for the display-by-id page.
    public ResultSet getMovieById(int movieId) throws Exception {
        // Keeping this ResultSet style to match your scriptlet workflow.
        Connection conn = getConnection();
        String sql = "SELECT movie_id, title, release_year, genre, rating, director, created_at " +
                     "FROM josh_movies_data WHERE movie_id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, movieId);

        return ps.executeQuery();
    }

// Insert a new movie record (movie_id auto-adds).
public int insertMovie(String title, int releaseYear, String genre, double rating, String director) throws Exception {
    // Insert the user input as a new row.
    String sql = "INSERT INTO josh_movies_data (title, release_year, genre, rating, director) VALUES (?, ?, ?, ?, ?)";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, title);
        ps.setInt(2, releaseYear);
        ps.setString(3, genre);
        ps.setDouble(4, rating);
        ps.setString(5, director);

        return ps.executeUpdate();
    }
}
// Update an existing movie record by movie_id.
  public int updateMovie(int movieId, String title, int releaseYear, String genre, double rating, String director) throws Exception {
        String sql = "UPDATE josh_movies_data SET title=?, release_year=?, genre=?, rating=?, director=? WHERE movie_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setInt(2, releaseYear);
            ps.setString(3, genre);
            ps.setDouble(4, rating);
            ps.setString(5, director);
            ps.setInt(6, movieId);

            return ps.executeUpdate();
        }
    }


    // Get all records (for the display-all table).
    public ResultSet getAllMovies() throws Exception {
        // Returning ResultSet so your JSP can loop it with scriptlets.
        Connection conn = getConnection();
        String sql = "SELECT movie_id, title, release_year, genre, rating, director, created_at " +
                     "FROM josh_movies_data ORDER BY movie_id";

        PreparedStatement ps = conn.prepareStatement(sql);
        return ps.executeQuery();
    }

    // Instructor convenience: create table (optional).
    public void createTable() throws Exception {
        // Create table if missing.
        String sql =
            "CREATE TABLE IF NOT EXISTS josh_movies_data (" +
            " movie_id INT AUTO_INCREMENT PRIMARY KEY," +
            " title VARCHAR(150) NOT NULL," +
            " release_year INT NOT NULL," +
            " genre VARCHAR(60) NOT NULL," +
            " rating DECIMAL(2,1) NOT NULL," +
            " director VARCHAR(120) NOT NULL," +
            " created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
            ")";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        }
    }

    // Instructor convenience: populate table (optional).
    public void populateTable() throws Exception {
        // Insert 10 starter rows.
        String sql =
            "INSERT INTO josh_movies_data (title, release_year, genre, rating, director) VALUES " +
            "('Iron Man', 2008, 'Superhero', 7.9, 'Jon Favreau')," +
            "('The Incredible Hulk', 2008, 'Superhero', 6.6, 'Louis Leterrier')," +
            "('Thor', 2011, 'Superhero', 7.0, 'Kenneth Branagh')," +
            "('Captain America: The First Avenger', 2011, 'Superhero', 6.9, 'Joe Johnston')," +
            "('The Avengers', 2012, 'Superhero', 8.0, 'Joss Whedon')," +
            "('Captain America: The Winter Soldier', 2014, 'Superhero', 7.8, 'Anthony Russo, Joe Russo')," +
            "('Guardians of the Galaxy', 2014, 'Superhero', 8.0, 'James Gunn')," +
            "('Black Panther', 2018, 'Superhero', 7.3, 'Ryan Coogler')," +
            "('Avengers: Infinity War', 2018, 'Superhero', 8.4, 'Anthony Russo, Joe Russo')," +
            "('Avengers: Endgame', 2019, 'Superhero', 8.4, 'Anthony Russo, Joe Russo')";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }

    // Instructor convenience: delete table (optional).
    public void deleteTable() throws Exception {
        // Drop the table for a clean reset.
        String sql = "DROP TABLE IF EXISTS josh_movies_data";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        }
    }
}