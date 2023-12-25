<div align="center">

  ![Screenshot_20230727_083857](https://github.com/JoaoPedroMoreira02/BruteForce_Web/assets/103542430/f87863dc-2283-43f6-be8e-4985256b0bdc)
  
  <img src="https://img.shields.io/badge/Language%20-Ruby-darkred.svg" style="max-width: 100%;">
  <img src="https://img.shields.io/badge/Tool%20-BruteForce Login Page-darkblue.svg" style="max-width: 100%;">
  <img src="https://img.shields.io/badge/OS%20-Linux-yellow.svg" style="max-width: 100%;">
  <img src="https://img.shields.io/badge/Hacking and CTF tool%20-teste?style=flat-square" style="max-width: 100%;">  
  <img src="https://img.shields.io/badge/Type%20-Script-black.svg" style="max-width: 100%;">
  <img src="https://img.shields.io/badge/License%20-GPL 2.0-purple.svg" style="max-width: 100%;">

</div>

# Bruteforce Login Page [ForceCannon]

This is a script made in ruby to attack login forms on web pages by brute force method with wordlists. It tests both the combination of passwords and usernames with the selected wordlist.


```bash
  git clone https://github.com/Jsmoreira02/BruteForce-Login-Page.git
```

## Launch the Attack

```./ForceCannon.rb -t http://test-vuln -u admin123 -P rockyou.txt -e The username or password provided is incorrect```

![ezgif com-video-to-gif-converter](https://github.com/Jsmoreira02/ForceCannon/assets/103542430/ec9b174f-6911-4413-b225-b8140aa5c500)


## Modes

- **Automatic -->** It was built to be as efficient as possible, however it is not a 100% efficient method and if you are having problems finding the credentials during the attack, please consider using the manual mode.

- **Manual -->** Just enter the username and password attribute and let it roll, this mode is 100% reliable.


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


# Warning:    
> I am not responsible for any illegal use or damage caused by this tool. It was written for fun, not evil and is intended to raise awareness about cybersecurity
