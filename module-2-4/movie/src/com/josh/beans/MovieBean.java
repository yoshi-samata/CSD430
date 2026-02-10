package com.josh.beans;

import java.io.Serializable;

/*MovieBean - This class is a JavaBean that holds ONE "movie record".
  Think of it like a container for data that we can pass around and display in JSP.

  JavaBean rules we follow here:
  1) private fields (makes data hidden)
  2) public getters/setters (controlled access to the data)
  3) public no-arg constructor (required by the JavaBean convention)
  4) implements Serializable (useful for sessions)
*/
public class MovieBean implements Serializable {

  // Serializable needs this number to keep class versions compatible
  private static final long serialVersionUID = 1L;

  // These are the data fields for the movie record (minimum 5 fields met)
  private String title;
  private int releaseYear;
  private String genre;
  private String director;
  private String mainActor;

  /*
    No-arg constructor:
    JavaBeans typically require a constructor that takes no parameters.
    This lets JSP / frameworks create the object easily.
  */
  public MovieBean() {}

  // Getter + Setter for title
  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }

  // Getter + Setter for releaseYear
  public int getReleaseYear() { return releaseYear; }
  public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

  // Getter + Setter for genre
  public String getGenre() { return genre; }
  public void setGenre(String genre) { this.genre = genre; }

  // Getter + Setter for director
  public String getDirector() { return director; }
  public void setDirector(String director) { this.director = director; }

  // Getter + Setter for mainActor
  public String getMainActor() { return mainActor; }
  public void setMainActor(String mainActor) { this.mainActor = mainActor; }

  /*
    Optional helper:
    This builds a simple "record subtitle" using the other fields.
    It keeps the JSP cleaner because we don’t have to rebuild this string in the page.
  */
  public String getSubtitle() {
    return genre + " \u2022 " + releaseYear;
  }
}
