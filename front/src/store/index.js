import { createStore } from 'vuex';
import VuexPersister from 'vuex-persister'
import axios from 'axios';
import 'es6-promise/auto'

const axiosInstance = axios.create({
    baseURL: 'http://localhost:4000/api',

});

const vuexPersist = new VuexPersister({
    key: 'my-app',
    storage: window.localStorage,
});

let user = localStorage.getItem('user')
if (!user) {
    user = {
        userId: '',
        pseudo: '',
        picture: '',
        isAdmin: '',
        bio: '',
        createdAt: '',
    };
} else {
    try {
        user = JSON.parse(user);

    } catch (ex) {
        user = {
            userId: '',
            pseudo: '',
            picture: '',
            isAdmin: '',
            bio: '',
            createdAt: '',
        };
    }
}

const store = createStore({
    state: {
        user: user,
        authInfos: {
            email: String(),
            password: String(),
        },
        userInfos: {
            id: Number(),
            username: String(),
            email: String(),
            firstname: String(),
            lastname: String(),
            age: Number(),
            role: String(),
            gender: String(),
            team_id: Number()

        },
        userId: Number(),
    },

    mutations: {
        logUser: (state, { user_id }) => {
            state.userId = user_id;
        },
        userInfos: (state, { id, firstname, lastname, username, email, age, gender, role, team_id }) => {
            state.userInfos.id = id
            state.userInfos.firstname = firstname
            state.userInfos.lastname = lastname
            state.userInfos.username = username
            state.userInfos.email = email
            state.userInfos.age = age
            state.userInfos.gender = gender
            state.userInfos.role = role
            state.userInfos.team_id = team_id
        },
    },

    actions: {
        login: ({ commit, dispatch }, authInfos) => {
            return new Promise((resolve, reject) => {
                commit;
                axiosInstance.post('/auth', authInfos, { withCredentials: true })
                    .then((response) => {
                        commit('logUser', response.data)
                        dispatch('getUserInfos')
                        resolve(response)
                    })
                    .catch((error) => {
                        reject(error)
                    })
            })
        },

        getUserInfos: ({ commit, state }) => {
            return new Promise((resolve, reject) => {
                commit;
                axiosInstance.get('/users/' + state.userId, { withCredientals: true })
                    .then((response) => {
                        commit('userInfos', response.data)
                        console.log(response.data)
                        resolve(response)
                    })
                    .catch((error) => {
                        reject(error)
                    })
            })
        }
    },
    plugins: [vuexPersist.persist]
})

export default store;

