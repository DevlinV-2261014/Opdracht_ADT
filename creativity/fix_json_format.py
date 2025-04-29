# This script adds a comma after each row. After, you need to put a [ at the beginning and a ] at the end of the file.

def main():
    # Read the file
    with open('IMDB.json', 'r') as file:
        # Add a , to the end of each line
        lines = file.readlines()
        lines = [line.strip() + ',' for line in lines]
        # Write the lines to a new file
    with open('IMDB2.json', 'w') as file:
        file.writelines(lines)
if __name__ == "__main__":
    main()