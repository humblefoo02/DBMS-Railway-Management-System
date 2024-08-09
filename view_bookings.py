import tkinter as tk
from tkinter import ttk
import mysql.connector

def fetch_bookings():
    # Create a database connection
    connection = mysql.connector.connect(
        host='127.0.0.1',
        user='root',
        password='Aman052!',  # Replace with your actual password
        database='train_reservation'
    )
    cursor = connection.cursor()
    query = "SELECT pnr, p_name, res_status, age, gender, seat_no FROM passenger;"
    cursor.execute(query)
    rows = cursor.fetchall()
    # Clear previous data
    for i in tree.get_children():
        tree.delete(i)
    # Inserting new rows
    for row in rows:
        tree.insert("", tk.END, values=row)
    cursor.close()
    connection.close()

# Set up the main window
root = tk.Tk()
root.title("View Bookings")
root.geometry("800x300")  # Adjust the size as per your requirement

# Setup Treeview
columns = ("pnr", "p_name", "res_status", "age", "gender", "seat_no")
tree = ttk.Treeview(root, columns=columns, show='headings')
tree.heading("pnr", text="PNR")
tree.heading("p_name", text="Passenger Name")
tree.heading("res_status", text="Reservation Status")
tree.heading("age", text="Age")
tree.heading("gender", text="Gender")
tree.heading("seat_no", text="Seat No")

# Adjust the column width
tree.column("pnr", width=100)
tree.column("p_name", width=150)
tree.column("res_status", width=130)
tree.column("age", width=50)
tree.column("gender", width=50)
tree.column("seat_no", width=100)

tree.pack(expand=True, fill='both')

# Button to go back
back_button = tk.Button(root, text="Back", command=root.destroy)
back_button.pack(pady=10)

# Initialize data loading
fetch_bookings()

root.mainloop()
