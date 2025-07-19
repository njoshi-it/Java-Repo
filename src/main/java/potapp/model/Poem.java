package potapp.model;

import java.sql.Timestamp;

public class Poem {
    private int id;
    private String title;
    private String content;
    private int userId;
    private int categoryId;
    private float rating;
    private Timestamp createdAt;
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // Constructors
    public Poem() {}

    public Poem(int id, String title, String content, int userId, int categoryId, float rating, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.userId = userId;
        this.categoryId = categoryId;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    // getters and setters

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getRating() {
        return rating;
    }
    public void setRating(float rating) {
        this.rating = rating;
    }
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
