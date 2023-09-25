String baseUrl = 'http://192.168.0.187:5001';

//AUTH
String urlRegister = '$baseUrl/user/register';
String urlLogin = '$baseUrl/user/login';
String getuserdata = '$baseUrl/user/getAllUser';

//crud
String inputMobil = '$baseUrl/gitar/create';
String editMobil = '$baseUrl/gitar/edit';
String getAllMobil = '$baseUrl/gitar/getAll';
String hapusMobil = '$baseUrl/gitar/hapus';
String getByIdMobil = '$baseUrl/gitar/getbyid';
String getByIdAdmin = '$baseUrl/gitar/getbyidadmin';
String editDatauser = '$baseUrl/user/editData';

//Transaksi
String createTransaksi = '$baseUrl/transaksi/create';
String getTransaksiUser = '$baseUrl/transaksi/getbyiduser';
String uploadFotoSelfie = '$baseUrl/transaksi/upload-bukti';
String getbarang = '$baseUrl/transaksi/getbarang';
String editstatus = '$baseUrl/transaksi/editstatus';
String getByIdUserLimit = '$baseUrl/transaksi/getbyiduserlimit';
String getAlltransaksi = '$baseUrl/transaksi/getall';
