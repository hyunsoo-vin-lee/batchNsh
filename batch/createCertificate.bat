@echo off
 
rem Apache Path
set ApachePath=C:\Apache24
 
rem OutputPath
set OutputPath=C:\Apache24\conf\certi
 
rem RootCA file name
set RootCAName=pdmroot
 
rem Domain Certificate file name
set DomainName=pdmtest.sangsin.com
 
rem Domain Name
set Domain=pdmtest.sangsin.com
 
rem ###################################################################################
rem SSL
set OPENSSL_CONF=%ApachePath%\conf\openssl.cnf
set OpenSslCommand=%ApachePath%\bin\openssl.exe
 
rem Generate RootCA Certificate
set RootCAKey=%OutputPath%\%RootCAName%.key
set RootCACertificate=%OutputPath%\%RootCAName%.crt
set RootCASerial=%OutputPath%\%RootCAName%.srl
 
if exist %RootCACertificate% (
    echo RootCA file exist. Skip RootCA file generation.
) else (
    "%OpenSSLCommand%" genrsa -des3 -out "%RootCAKey%" -passout pass:qwer1234!@#$ 3650
    "%OpenSSLCommand%" req -new -x509 -sha256 -nodes -days 3650 -key "%RootCAKey%" -out "%RootCACertificate%" -passin pass:qwer1234!@#$ -subj "/C=KO/ST=Seoul/L=Gasan/O=ATIS/OU=PLM/CN=%RootCAName%"
)
 
rem Generate Domain Certificate
set DomainKey=%OutputPath%\%DomainName%.key
set DomainCertifcateRequest=%OutputPath%\%DomainName%.csr
set DomainCertifcateExtension=%OutputPath%\%DomainName%.ext
set DomainCertifcate=%OutputPath%\%DomainName%.crt
 
echo authorityKeyIdentifier=keyid,issuer > "%DomainCertifcateExtension%"
echo basicConstraints=CA:FALSE >> "%DomainCertifcateExtension%"
echo keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment >> "%DomainCertifcateExtension%"
echo subjectAltName = @alt_names >> "%DomainCertifcateExtension%"
echo [alt_names] >> "%DomainCertifcateExtension%"
echo DNS.1=%Domain% >> "%DomainCertifcateExtension%"
 
"%OpenSSLCommand%" genrsa -out "%DomainKey%" 2048
"%OpenSSLCommand%" req -new -sha256 -key "%DomainKey%" -out "%DomainCertifcateRequest%" -subj "/C=KO/ST=Seoul/L=Gasan/O=ATIS/OU=PLM/CN=%Domain%"
"%OpenSSLCommand%" x509 -req -sha256 -days 3650 -in "%DomainCertifcateRequest%" -out "%DomainCertifcate%" -extfile "%DomainCertifcateExtension%" -CA "%RootCACertificate%" -CAkey "%RootCAKey%" -passin pass:qwer1234!@#$ -CAcreateserial -CAserial "%RootCASerial%"
 
echo Done.