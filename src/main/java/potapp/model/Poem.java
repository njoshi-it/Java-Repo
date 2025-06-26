package potapp.model;

public class Poem {
    private int id;
    private String title;
    private String content;
    private String category;
    private int userId;

    // Constructors, including no-arg and parameterized ones (optional)

    public Poem() {}

    public Poem(int id, String title, String content, String category, int userId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.userId = userId;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for title
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    // Getter and Setter for content
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    // Getter and Setter for category
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }

    // Getter and Setter for userId
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
}
