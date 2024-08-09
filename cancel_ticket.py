import tkinter as tk
from tkinter import messagebox
import mysql.connector


def cancel_booking():
    # Retrieve data from entry fields
    pnr = pnr_entry.get()
    p_name = name_entry.get()

    # Check if any field is empty
    if not (pnr and p_name):
        messagebox.showerror("Error", "Both PNR and Name are required!")
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
        # SQL query to update the booking status
        query = ("UPDATE passenger SET res_status = 'Cancelled' WHERE pnr = %s AND p_name = %s")
        data = (pnr, p_name)
        cursor.execute(query, data)
        if cursor.rowcount == 0:
            messagebox.showinfo("Failure", "No booking found with the given PNR and Name.")
        else:
            connection.commit()
            messagebox.showinfo("Success", "Booking cancelled successfully!")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Failed to cancel booking: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

    # Clear the entry fields
    pnr_entry.delete(0, tk.END)
    name_entry.delete(0, tk.END)


# Set up the main window
root = tk.Tk()
root.title("Cancel Booking")
root.geometry("400x200")  # Adjust the size as per your requirement

# Labels and Entry widgets
tk.Label(root, text="PNR:").grid(row=0, column=0, padx=10, pady=10)
pnr_entry = tk.Entry(root)
pnr_entry.grid(row=0, column=1, padx=10, pady=10)

tk.Label(root, text="Name:").grid(row=1, column=0, padx=10, pady=10)
name_entry = tk.Entry(root)
name_entry.grid(row=1, column=1, padx=10, pady=10)

# Button to submit data
cancel_button = tk.Button(root, text="Cancel Booking", command=cancel_booking)
cancel_button.grid(row=2, columnspan=2, pady=20)

root.mainloop()
