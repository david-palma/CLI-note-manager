# CLI Note Manager

A lightweight and straightforward command-line tool for managing notes. Easily create, edit, view, list, and delete note files directly from the terminal. The script uses your preferred text editor and is simple to configure.

## Features

- **List Notes**: Display all notes in the configured directory, along with their size and last modification date.
- **Create a Note**: Quickly create a new note using your preferred text editor.
- **Edit an Existing Note**: Open and edit an existing note file.
- **View Note Contents**: Display the contents of a specific note in the terminal.
- **Delete a Note**: Delete a note file with confirmation.
- **Help Command**: Display usage instructions.

## Requirements

- A Windows terminal (Command Prompt or compatible).
- A text editor such as:
  - [Micro](https://micro-editor.github.io/) (preferred if installed).
  - Notepad (default fallback editor).

## Setup Instructions

### Step 1: Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/yourusername/CLI-note-manager.git
cd CLI-note-manager
```

### Step 2: Configure the Script

1. **Set the Notes Directory**:

   - By default, the script stores notes in:
     - `D:\Documents\.notes` if `D:\` exists,
     - `C:\Documents\.notes` otherwise.
   - Ensure you have write permissions for the chosen directory. If it does not exist, it will be created automatically.

2. **Configure the Text Editor**:

   - The script uses the `EDITOR` variable to determine the preferred text editor.
   - It automatically checks for `micro.exe`. If not found, it defaults to `notepad.exe`.

   To use a different editor:

   - Open the script and modify the `EDITOR` variable near the top:
     ```bash
     set "EDITOR=path\to\your\preferred\editor.exe"
     ```
   - Replace `path\to\your\preferred\editor.exe` with the full path to your editor.

### Step 3: Add the Script to Your PATH

To make the script easily accessible from any terminal window, add it to your system's `PATH` environment variable:

1. **Copy the script** to a directory already included in your `PATH`, or
2. **Add the script's directory to your `PATH`** by running the following command in the terminal (replacing `C:\path\to\script-directory` with the actual path to the directory containing the script):
   ```bash
   set PATH=%PATH%;C:\path\to\script-directory
   ```
   Alternatively, you can permanently add the script directory to the `PATH` by updating your system's environment variables through the Control Panel.

## Usage

To use the script, run the `note` command followed by an option and an optional filename.

```text
Usage: note [OPTION] [FILENAME]

Options:
  -l, --list      List all note files (default if no option is provided).
  -n, --new       Create a new note. If no filename is given, you will be prompted to enter one.
  -e, --edit      Edit an existing note. If no filename is given, you will be prompted to enter one.
  -d, --delete    Delete a note file. If no filename is given, you will be prompted to enter one.
  -s, --show      Display the contents of a note. If no filename is given, you will be prompted to enter one.
  -h, --help      Display help information.

The default editor is "micro".
You can change it by modifying the EDITOR variable in the script.
```

### Examples

Here are some examples of how to use the script along with the expected outputs:

1. **List Notes**

   To list all the notes in your notes directory, use the `-l` or `--list` option:

   ```text
   note -l

   List of files:
   --------------
   Last edit            Size    File
   2024-11-15 10:20 AM  500 kB  mynote1.txt
   2024-11-14 02:45 PM  1 MB    mynote2.txt
   2024-11-10 09:30 AM  200 kB  mynote3.txt

   Number of note files found: 3
   ```

   This will display all notes in the directory along with their last modified date and file size.

2. **Create a New Note**

   To create a new note, provide a filename (e.g., `mynote.txt`):

   ```text
   note -n mynote.txt
   Enter the note content (type 'exit' to save and exit):
   ```

   The script will open the text editor for you to write the note. Once you are finished, save and close the editor. If you didn't provide a filename, it will prompt you for one.

3. **Edit an Existing Note**

   To edit a note, specify the filename of the note you want to edit:

   ```text
   note -e mynote.txt
   ```

   The script will open the text editor with the contents of `mynote.txt`. After making changes, save and close the editor.

4. **Delete a Note**

   To delete a note, specify the filename of the note you want to delete:

   ```text
   note -d mynote.txt
   mynote.txt, Delete (Y/N)?
   ```

   The script will prompt for confirmation before deleting the file.
   If you enter a filename and it doesn't exist, it will show an error like:

   ```text
   Error: File "mynote.txt" not found.
   ```

5. **Show the Contents of a Note**

   To display the contents of a note, specify the filename:

   ```text
   note -s mynote.txt
   --------------------------------------
   This is the content of my note.
   It has multiple lines of text.
   --------------------------------------
   ```

   If you enter a filename and it doesn't exist, it will show an error like:

   ```text
   Error: File "mynote.txt" not found.
   ```

6. **Display Help**
   To display the help message, use the `-h` or `--help option`:

   ```
   note -h
   A very simple CLI-based note taking and note files manager application.

   Usage: note [OPTION] [FILENAME]

   Options:
     -l, --list      List all note files (default if no option is provided).
     -n, --new       Create a new note. If no filename is given, you will be prompted to enter one.
     -e, --edit      Edit an existing note. If no filename is given, you will be prompted to enter one.
     -d, --delete    Delete a note file. If no filename is given, you will be prompted to enter one.
     -s, --show      Display the contents of a note. If no filename is given, you will be prompted to enter one.
     -h, --help      Display help information.

   The default editor is "micro".
   You can change it by modifying the EDITOR variable in the script.
   ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
