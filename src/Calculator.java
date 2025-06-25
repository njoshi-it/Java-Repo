import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Calculator extends JFrame implements ActionListener {
    JTextField inputField;
    double num1, num2;
    String operator;
    boolean isOperatorClicked = false;

    public Calculator() {
        setTitle("Simple Calculator");
        setSize(350, 450);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(null);

        inputField = new JTextField();
        inputField.setBounds(20, 20, 300, 40);
        inputField.setEditable(false);
        inputField.setFont(new Font("Arial", Font.BOLD, 20));
        add(inputField);

        String[] buttonLabels = {
            "7", "8", "9", "/", 
            "4", "5", "6", "*", 
            "1", "2", "3", "-", 
            "0", "C", "=", "+"
        };

        int x = 20, y = 80;
        for (int i = 0; i < buttonLabels.length; i++) {
            JButton btn = new JButton(buttonLabels[i]);
            btn.setBounds(x, y, 65, 50);
            btn.setFont(new Font("Arial", Font.BOLD, 16));
            btn.addActionListener(this);
            add(btn);

            x += 75;
            if ((i + 1) % 4 == 0) {
                x = 20;
                y += 60;
            }
        }
    }

    public void actionPerformed(ActionEvent e) {
        String cmd = e.getActionCommand();

        // If a number is clicked
        if (cmd.matches("[0-9]")) {
            if (isOperatorClicked) {
                inputField.setText(""); // clear for second number
                isOperatorClicked = false;
            }
            inputField.setText(inputField.getText() + cmd);
        }

        // If an operator is clicked
        else if (cmd.matches("[+\\-*/]")) {
            try {
                num1 = Double.parseDouble(inputField.getText());
                operator = cmd;
                isOperatorClicked = true;
            } catch (NumberFormatException ex) {
                inputField.setText("Error");
            }
        }

        // Equals (=) clicked
        else if (cmd.equals("=")) {
            try {
                num2 = Double.parseDouble(inputField.getText());
                String result;

                switch (operator) {
                    case "+" -> result = String.valueOf(num1 + num2);
                    case "-" -> result = String.valueOf(num1 - num2);
                    case "*" -> result = String.valueOf(num1 * num2);
                    case "/" -> {
                        if (num2 == 0) {
                            result = "∞";
                        } else {
                            result = String.valueOf(num1 / num2);
                        }
                    }
                    default -> result = "Error";
                }

                inputField.setText(result);
             }catch (NumberFormatException ex) {
                inputField.setText("Error");
                 }
            
        }

        // Clear (C) clicked
        else if (cmd.equals("C")) {
            inputField.setText("");
            num1 = num2 = 0;
            operator = "";
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new Calculator().setVisible(true);
        });
    }
}
