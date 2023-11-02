<script setup>
import DashboardNavButton from '../dashboard/DashboardNavButton.vue';

</script>

<template>
    <div class="DashboardNav">
        <div class="DashboardNav__iconContainer">
            <img class="DashboardNav__iconContainer-icon" src="src/assets/images/ic_logo.svg" alt="Time manager logo">
        </div>

        <div class="DashboardNav__buttonContainer">
            <DashboardNavButton v-for="(information, index) in buttonInformation" 
            :key="index" 
            :is-button-selected="information.isButtonSelected"
            :button-text="information.buttonText"
            :src="information.isButtonSelected ? information.buttonIconSelected : information.buttonIcon"
            :alt="information.alt"

            @toggle-selection="toggleButton(index, $event)"
            />
            
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            buttonInformation: [
                {
                    buttonText: "Dashboard",
                    buttonIcon: "src/assets/images/ic_dashboard.svg", 
                    buttonIconSelected: "src/assets/images/ic_dashboard-selected.svg",
                    alt: "Dashboard icon",
                    isButtonSelected: true
                },
                {
                    buttonText: "Analytics",
                    buttonIcon: "src/assets/images/ic_analytics.svg", 
                    buttonIconSelected: "src/assets/images/ic_analytics-selected.svg",
                    alt: "Analytics icon",
                    isButtonSelected: false
                },
                {
                    buttonText: "Clock",
                    buttonIcon: "src/assets/images/ic_clocking.svg", 
                    buttonIconSelected: "src/assets/images/ic_clocking-selected.svg",
                    alt: "Clock icon",
                    isButtonSelected: false
                },
                {
                    buttonText: "Settings",
                    buttonIcon: "src/assets/images/ic_settings.svg", 
                    buttonIconSelected: "src/assets/images/ic_settings-selected.svg",
                    alt: "Settings icon",
                    isButtonSelected: false
                },
            ],
        };
    },
    methods: {
        toggleButton(index, isSelected) {
            this.buttonInformation.forEach((button, i) => {
                if (i !== index) {
                    button.isButtonSelected = false;
                }
            });
            this.buttonInformation[index].isButtonSelected = isSelected;
        },
    },
}

</script>

<style lang="scss">
.DashboardNav {
    @include flex-column;
    height: 100vh;
    max-width: 22%;
    border: 1px solid red;
    padding: $dimension-medium $dimension-default;

    gap: 128px;

    &__iconContainer {
        display: flex;
        justify-content: center;

        &-icon {
            width: 180px;
        }
    }

    &__buttonContainer {
        @include flex-column;
        gap: $dimension-medium;

    }
}
</style>