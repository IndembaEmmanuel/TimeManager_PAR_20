<script setup>
    import TopBar from '@/components/TopBar.vue'
    import ButtonNavBar from "@/components/ButtonNavBar.vue"
</script>

<template>
    <TopBar />
    <div class="Dashboard">
        <div class="NavBar">
            <div class="NavBar__container">
                <ButtonNavBar text="Dashboard" image1="src/assets/icons/Dashboard_hovered.svg" image2="src/assets/icons/Dashboard.svg" componentName="Dashboard" :switchComponent="switchComponent" />
                <ButtonNavBar text="TimeManager" image1="src/assets/icons/Dashboard_hovered.svg" image2="src/assets/icons/Dashboard.svg" componentName="TimeManager" :switchComponent="switchComponent" />
                <ButtonNavBar text="Tasks" image1="src/assets/icons/Dashboard_hovered.svg" image2="src/assets/icons/Dashboard.svg" componentName="Tasks" :switchComponent="switchComponent" />                
            </div>
        </div>
        <div class="Dashboard__background">
            <component :is="currentComponent" />
        </div>
    </div>
</template>

<script>
    import Dashboard from '@/components/Dashboard.vue'
    import TimeManager from '@/components/TimeManager.vue'
    import Tasks from '@/components/Tasks.vue'

    export default {
        components: {
            Dashboard,
            TimeManager,
            Tasks,
        },
        data() {
            return {
                currentComponent: 'Dashboard'
            }
        },
        methods: {
            switchComponent(componentName) {
                this.currentComponent = componentName;
            },
        },

    }
</script>

<style lang="scss">
    .NavBar {
        height: 100vh;
        width: 300px;

        &__container {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            height: 270px;
            width: 100%;
        }
    }

    .Dashboard {
        display: flex;
        flex-direction: row;
        width: 100%;
        justify-content: space-between;

        &__background {
            height: 100vh;
            width: 1250px;
            background-color: aqua;
            border-radius: 38px 0px 0px 0px;
        }
    }
</style>
