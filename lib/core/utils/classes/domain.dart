class DomainUrl{
  final String url;

  DomainUrl({required this.url});



  static DomainUrl? tryParse(String formatingString) {

    final comprehensiveDomainRegex = RegExp(r'^(?!:\/\/)([a-zA-Z0-9-_]{1,63}\.)+[a-zA-Z]{2,6}$');

    if(comprehensiveDomainRegex.hasMatch(formatingString)) {
      return DomainUrl(url: formatingString);
    } else {
      throw FormatException('Given domain name does not match domain pattern! Formating url is $formatingString');
    }
    
  }




}