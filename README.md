![Screenshot_20230727_083857](https://github.com/JoaoPedroMoreira02/BruteForce_Web/assets/103542430/f87863dc-2283-43f6-be8e-4985256b0bdc)

# Bruteforce Login Page [ForceCannon]

This is a script made in ruby to attack login forms on web pages by brute force method with wordlists. It tests both the combination of passwords and usernames with the selected wordlist.


```bash
  git clone https://github.com/JoaoPedroMoreira02/BruteForce-Login-Page.git
```

## [Help] Output

```bash
Usage: ./app.rb [-t/--target] [-u/--username] [-P/--Password_list]
    -t, --target TARGET              Target IP address or domain name
    -u, --username USER_VALUE        Username value
    -p, --password PASSWORD_VALUE    Password value
    -U, --Users_list WORDLIST        Wordlist of Usernames
    -P, --Password_list WORDLIST     Wordlist of Passwords
    -e, --error_msg AUTH_ERROR_MSG   Authentication error message to check if the attack was successful
    -h, --help                       show this help message and exit

```

```bash 
./ForceCannon.rb -t http://test-vuln -u admin123 -P rockyou.txt -e The username or password provided is incorrect 
```

## How it works (Detailed)

The script works with the `name` attribute of the HTML element contained within the `<form>` tag. The user will use this to enter the `username` and `password` values and submit the data request for authentication.

Using a good wordlist (dictionary) of possible passwords or usernames, the script will continuously insert in the username or password attribute with the items in the list until it finds the right match and the authentication request is approved.

For this to occur correctly, the user must enter the identifier(value) of the `name` attribute of the username and password field in the program, and the target URL must contain the value of the `action` attribute of the `<form>` tag, which tells where to send the form-data when the form is submitted and insert the `error message` that the application returns when the credentials are incorrect, so that it is given as success if the error message is no longer in the body of the page after the request.

```bash
<form action="/action_page.php" method="get">
  Username <input type="text" id="name" name="nameValue"><br><br>
  Password <input type="password" id="pass" name="passValue"><br><br>
  Log-in <input type="submit" value="Submit">
</form>
```


![Screenshot_20230728_074024](https://github.com/JoaoPedroMoreira02/BruteForce-Login-Page/assets/103542430/ac3f4494-c883-4c32-8433-58044b25b2c8)
