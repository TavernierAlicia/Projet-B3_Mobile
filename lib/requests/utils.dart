const String    BASE_URL = "http://api.orderndrink.com/app/" ;

const int       SERVER_RESPONSE_NO_ERROR = 0 ;
const int       SERVER_RESPONSE_NO_ROUTE = 1 ;
const int       SERVER_RESPONSE_WRONG_CREDENTIALS = 2 ;
const int       SERVER_RESPONSE_MAIL_EXISTS = 3 ;
const int       SERVER_RESPONSE_MISMATCH_PASSWORD = 4 ;
const int       SERVER_RESPONSE_ERROR = 5 ;
const int       SERVER_RESPONSE_FIELD_MISSING = 6 ;
const int       SERVER_RESPONSE_NO_PASSWORD = 7 ;
const int       SERVER_RESPONSE_SAME_PASSWORD = 8 ;
const int       SERVER_RESPONSE_INCORRECT_PASSWORD = 9 ;

String          getServerErrorMessage(int errorCode) {
  print("In get server error message ; error code = $errorCode");
  switch (errorCode) {
    case 0 :
      return "Success !" ;
    case 2 :
      return "Les identifiants sont invalides." ;
    case 3 :
      return "Cet email est déjà utilisé." ;
    case 4 :
      return "Les mots de passe ne correspondent pas" ;
    case 6 :
      return "Certains champs sont incomplets." ;
    case 7 :
      return "" ;
    case 8 :
      return "Les mots de passe sont identiques." ;
    case 9 :
      return "Mot de passe incorrect." ;
    default : /// Triggered on cases 1 & 5.
      return "Une erreur est survenue" ;
  }
}
/*
### ERRORS
0 --> No error
1 --> This route doesn't exists
2 --> Login or password wrong
3 --> Mail already exists
4 --> Mismatch passwords
5 --> An error occured
6 --> Field(s) missing
7 --> No password
8 --> Same passwords
9 --> Incorrect password
 */