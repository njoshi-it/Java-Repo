import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class Calculator extends Application {

    private TextField inputField = new TextField();
    private double num1 = 0;
    private String operator = null;
    private boolean isOperatorClicked = false;

    @Override
    public void start(Stage stage) {
        inputField.setEditable(false);
        inputField.setStyle("-fx-font-size: 20px;");
        inputField.setPrefHeight(50);

        GridPane grid = new GridPane();
        grid.setAlignment(Pos.CENTER);
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(10));

        String[][] buttons = {
                {"7", "8", "9", "/"},
                {"4", "5", "6", "*"},
                {"1", "2", "3", "-"},
                {"0", "C", "=", "+"}
        };

        for (int row = 0; row < buttons.length; row++) {
            for (int col = 0; col < buttons[row].length; col++) {
                String label = buttons[row][col];
                Button btn = new Button(label);
                btn.setPrefSize(60, 60);
                btn.setStyle("-fx-font-size: 18px;");
                btn.setOnAction(e -> handleInput(label));
                grid.add(btn, col, row);
            }
        }

        VBox root = new VBox(10, inputField, grid);
        root.setPadding(new Insets(20));
        Scene scene = new Scene(root, 300, 400);

        stage.setTitle("JavaFX Calculator");
        stage.setScene(scene);
        stage.show();
    }

    private void handleInput(String cmd) {
        if (cmd.matches("[0-9]")) {
            if (isOperatorClicked) {
                inputField.clear();
                isOperatorClicked = false;
            }
            inputField.appendText(cmd);
        } else if (cmd.matches("[+\\-*/]")) {
            if (!inputField.getText().isEmpty()) {
                num1 = Double.parseDouble(inputField.getText());
                operator = cmd;
                isOperatorClicked = true;
            }
        } else if (cmd.equals("=")) {
            if (inputField.getText().isEmpty() || operator == null) {
                inputField.setText("Error");
                return;
            }
            double num2 = Double.parseDouble(inputField.getText());
            String result;
            switch (operator) {
                case "+" -> result = String.valueOf(num1 + num2);
                case "-" -> result = String.valueOf(num1 - num2);
                case "*" -> result = String.valueOf(num1 * num2);
                case "/" -> result = (num2 == 0) ? "Undefined" : String.valueOf(num1 / num2);
                default -> result = "Error";
            }
            inputField.setText(result);
        } else if (cmd.equals("C")) {
            inputField.clear();
            num1 = 0;
            operator = null;
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
