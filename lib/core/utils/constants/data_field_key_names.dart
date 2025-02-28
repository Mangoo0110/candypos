
class FirebaseStorageCollections{
  static String kUserProfile = 'userProfile';
  static String kPage = 'page';
  static String kChannel = 'channel';
  static String kPost = 'post';

}

class FirestoreUserPrv{
  static String kCollection = 'usersPrivate';
  static String kdocId = 'docId';
  static String kemail = 'email'; 
  static String kcountry = 'country'; 
  static String kaddress = 'address';
  static String kcontactNo = 'contactNo';
  static String kfullName = 'fullName';
  static String kjoinedAt = 'joinedAt';
  static String kimageUrl = 'imageUrl';
  static String kdescription = 'description';
}


class FirestoreUserPub{
  static String kCollection = 'usersPublic';
  static String kdocId = 'docId';
  static String kcountry = 'country'; 
  static String kaddress = 'address';
  static String kfullName = 'fullName';
  static String kimageUrl = 'imageUrl';
  static String kdescription = 'description';
}





/// kType is the type of document is present in the database at the moment. Means is the document is removed; added or modified.
/// Right now we only care about the types removed; added. If a document is added or modified; we simply set its type status as added.
const String kType = 'type';
const String kIsSynced = 'isSynced';


// static String kdormitoryId = 'dormitoryId';
// static String kdormitoryName = 'dormitoryName';
// static String kcreatedAt = 'createdAt';
// static String kupdatedAt = 'updatedAt';

// static String kcontent = 'content';
// static String kimageIdList = 'imageIdList';

// static String kFirestoreComplainCollection = 'complains';
// static String kcomplainType = 'complainType'; 


//static String kupdatedAt = 'updatedAt';


class FireStoreModerators{

  static String kCollection = 'moderators';
  static String role = 'role' ;
  static String userId = 'userId' ;
  static String addedBy = 'addedBy' ;
  static String addedAt = 'addedAt' ;
}