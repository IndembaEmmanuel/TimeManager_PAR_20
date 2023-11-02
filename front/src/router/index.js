import { createRouter, createWebHistory } from 'vue-router'

import Login from '../views/LoginView.vue';
import Dashboard from '../views/DashboardMock.vue';

const routes = [
  { path: '/', redirect: "/login"},
  { path: "/login", component: Login },
  { path: "/dashboard", component: Dashboard },  
];

const router = createRouter({ history: createWebHistory(), routes });

export default router
