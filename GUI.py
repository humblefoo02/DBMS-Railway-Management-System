import tkinter as tk
from tkinter import messagebox
import subprocess

def login_user():
    username = user_id_entry.get()
    password = password_entry.get()
    if username == 'ayushi' and password == '123':
        open_reservation_system()
    else:
        messagebox.showerror("Login Failed", "Invalid username or password")

def open_reservation_system():
    # Destroying the login frame and setting up the reservation system
    login_frame.pack_forget()  # Hide login frame
    setup_reservation_interface()

def setup_reservation_interface():
    reservation_frame.pack(expand=True)
    tk.Label(reservation_frame, text="Welcome to Train Reservation System", font=('Helvetica', 14, 'normal'), bg='#ffffff').pack(pady=20)
    # Each button corresponds to a different Python file
    tk.Button(reservation_frame, text="Book Ticket", font=('Helvetica', 12, 'normal'), bg='#4CAF50', fg='white', command=lambda: run_script("book_ticket.py")).pack(pady=10, padx=20, fill='x')
    tk.Button(reservation_frame, text="Cancel Ticket", font=('Helvetica', 12, 'normal'), bg='#f44336', fg='white', command=lambda: run_script("cancel_ticket.py")).pack(pady=10, padx=20, fill='x')
    tk.Button(reservation_frame, text="View Bookings", font=('Helvetica', 12, 'normal'), bg='#2196F3', fg='white', command=lambda: run_script("view_bookings.py")).pack(pady=10, padx=20, fill='x')

def run_script(script_name):
    # Running the Python script using subprocess
    try:
        subprocess.run(['python', script_name], check=True)
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Execution Failed", f"Failed to run script: {script_name}\n{str(e)}")

# Setting up the main GUI window
root = tk.Tk()
root.title("Train Reservation System")
root.geometry('500x400')  # Updated window size for better layout
root.configure(bg='#ffffff')  # Background color

# Login frame
login_frame = tk.Frame(root, bg='#ffffff', pady=20)
login_frame.pack(expand=True)

# Reservation frame setup (hidden initially)
reservation_frame = tk.Frame(root, bg='#ffffff', pady=20)

# Adding labels and entries for login
tk.Label(login_frame, text="Username:", bg='#ffffff', font=('Helvetica', 12, 'normal')).grid(row=0, column=0, padx=10, pady=10)
user_id_entry = tk.Entry(login_frame, font=('Helvetica', 12, 'normal'), width=25)
user_id_entry.grid(row=0, column=1, pady=10)

tk.Label(login_frame, text="Password:", bg='#ffffff', font=('Helvetica', 12, 'normal')).grid(row=1, column=0, padx=10, pady=10)
password_entry = tk.Entry(login_frame, font=('Helvetica', 12, 'normal'), show="*", width=25)
password_entry.grid(row=1, column=1, pady=10)

# Login button
login_button = tk.Button(login_frame, text="Login", command=login_user,
                         font=('Helvetica', 12, 'normal'), bg='#4CAF50', fg='white', width=15)
login_button.grid(row=2, columnspan=2, pady=20)

# Centering the window
root.eval('tk::PlaceWindow . center')

root.mainloop()
