<script setup>
import DashboardNav from '../components/dashboard/DashboardNav.vue'
import DashboardContent from '../components/DashboardContent.vue'

</script>

<template>
    <div class="DashboardView"> 
        <div class="DashboardView__content">
            <DashboardNav/>
            <DashboardContent/>
        </div>

    </div>


</template>


<style lang="scss">
.DashboardView {
    height: 100vh;
    overflow: hidden;

    &__content {
        display: flex;
        width: 100%;
    }
}


</style>