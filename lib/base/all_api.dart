

//const baseUrl="http://dev.rokkhi.com:5000/api/";
//const baseUrl="http://localhost:5000/api/";
const baseUrl="http://192.168.0.105:5000/api/";

const uploadImageUrl = baseUrl + "v1/image/uploadSingle";


const sensorAPI=baseUrl+"v1/door-sensor/getDeviceSensors";

const addDeviceAPI=baseUrl+"v1/device/addOrUpdateDevice";

const getDeviceAPI=baseUrl+"v1/device/getAllDevices";

const editDeviceAPI=baseUrl+"device/updateDevice";

const deleteDeviceAPI=baseUrl+"v1/device/deleteDevice";

const createProfileAPI=baseUrl+"v1/user/registerOrUpdate";

const getUserAPI=baseUrl+"v1/user/getUserDetails";

const updateUserAPI=baseUrl+"user/updateUser";

const startEndNotification=baseUrl+"v1/user/updateUserDetails";

