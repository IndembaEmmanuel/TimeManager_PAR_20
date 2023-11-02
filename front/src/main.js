import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import ApiServices from './services/apiServices.js'
import store from './store';

const app = createApp(App)

app.config.globalProperties.$apiServices = new ApiServices()

app.use(router)
app.use(store)

app.mount('#app')