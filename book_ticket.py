import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector


def book_ticket():
    # Retrieve data from entry fields
    pnr = pnr_entry.get()
    p_name = name_entry.get()
    res_status = status_entry.get()
    age = age_entry.get()
    gender = gender_entry.get()
    seat_no = seat_no_entry.get()

    # Check if any field is empty
    if not (pnr and p_name and res_status and age and gender and seat_no):
        messagebox.showerror("Error", "All fields are required!")
        return

    try:
        # Create a database connection
        connection = mysql.connector.connect(
            host='127.0.0.1',
            user='root',
            password='Aman052!',  # Replace with your actual password
            database='train_reservation'
        )
        cursor = connection.cursor()
        # SQL query to insert a new record
        query = ("INSERT INTO passenger (pnr, p_name, res_status, age, gender, seat_no) "
                 "VALUES (%s, %s, %s, %s, %s, %s)")
        data = (pnr, p_name, res_status, age, gender, seat_no)
        cursor.execute(query, data)
        connection.commit()
        messagebox.showinfo("Success", "Ticket booked successfully!")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Failed to book ticket: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

    # Clear the entry fields
    pnr_entry.delete(0, tk.END)
    name_entry.delete(0, tk.END)
    status_entry.delete(0, tk.END)
    age_entry.delete(0, tk.END)
    gender_entry.delete(0, tk.END)
    seat_no_entry.delete(0, tk.END)


# Set up the main window
root = tk.Tk()
root.title("Book Ticket")
root.geometry("400x300")  # Adjust the size as per your requirement

# Labels and Entry widgets
tk.Label(root, text="PNR:").grid(row=0, column=0, padx=10, pady=10)
pnr_entry = tk.Entry(root)
pnr_entry.grid(row=0, column=1, padx=10, pady=10)

tk.Label(root, text="Name:").grid(row=1, column=0, padx=10, pady=10)
name_entry = tk.Entry(root)
name_entry.grid(row=1, column=1, padx=10, pady=10)

tk.Label(root, text="Reservation Status:").grid(row=2, column=0, padx=10, pady=10)
status_entry = tk.Entry(root)
status_entry.grid(row=2, column=1, padx=10, pady=10)

tk.Label(root, text="Age:").grid(row=3, column=0, padx=10, pady=10)
age_entry = tk.Entry(root)
age_entry.grid(row=3, column=1, padx=10, pady=10)

tk.Label(root, text="Gender (M/F):").grid(row=4, column=0, padx=10, pady=10)
gender_entry = tk.Entry(root)
gender_entry.grid(row=4, column=1, padx=10, pady=10)

tk.Label(root, text="Seat No:").grid(row=5, column=0, padx=10, pady=10)
seat_no_entry = tk.Entry(root)
seat_no_entry.grid(row=5, column=1, padx=10, pady=10)

# Button to submit data
submit_button = tk.Button(root, text="Book Ticket", command=book_ticket)
submit_button.grid(row=6, columnspan=2, pady=20)

root.mainloop()
