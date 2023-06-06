class Helpers {
  static findById(list, String id) {
    var myListFiltered = list.where((e) => e == id);
    if (myListFiltered.length > 0) {
      return myListFiltered;
    } else {
      // Element is not found
      return null;
    }
  }
}
