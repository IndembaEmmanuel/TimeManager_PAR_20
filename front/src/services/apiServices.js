import axios from "axios";
import 'es6-promise/auto';

export default class ApiServices {
    constructor() {
        this.api = axios.create({
            baseURL: "http://localhost:4000/api",
            withCredentials: true,
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
            },
        });
    }

    getUser = async () => {
        try {
            const res = await axios.get(`http://localhost:4000/api/users/5`);
        
            if (res.request.status !== 200) {
                return null;
            }
            return res.data;
        }
        catch (err) {
            console.log(err);
        }
    }
}