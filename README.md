### My scrips and other tools for hacking

#### SUIDBufferOverflowGenerator.py - A script that generates a input string to a simple buffer overflow binary
- Running executable with increasing size arguments
- Generating non repeating string
- Running executable in r2 with the generated string
- Finding eip position using r2 output of crash address
- Confirming EIP position
- Generating shellcode for a SUID binary - for user id
- Testing for bad characters
- Encoding shellcode to avoid bad characters
- Looking for useful jmp and call instructions
- Generating the full payload
- Checking if ASLR is turned off

#### GetAzureCredz - A script to get locally saved Azure creds when you have certain permissions
minimized and easier to read version of:
- https://github.com/CloudyKhan/Azure-AD-Connect-Credential-Extractor/blob/main/decrypt.ps1
- https://github.com/VbScrub/AdSyncDecrypt/blob/master/MainModule.vb  
To easier see how it works you can run each line on the PS command line.

#### More to come :)
