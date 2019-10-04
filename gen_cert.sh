#This can be used to generate a security certificate.  I used them to enable SSL
#   encryption of my Jupyter Notebook connections over https
openssl req -x509 -nodes -days 1825 -newkey rsa:2048 -keyout jupnb.key -out jupnbcert.pem
