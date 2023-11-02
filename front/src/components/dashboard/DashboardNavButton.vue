<script setup>
import { initSquircle } from "/src/common/squircle.js"

initSquircle()
</script>

<template>
    <div @click="toggleButtonSelection" :class="['DashboardNavButton', isButtonSelected ? 'buttonSelected' : '']">
        <img class="DashboardNavButton-icon" src="" alt="" v-bind="$attrs">
        <p :class="['DashboardNavButton-text', isButtonSelected ? 'buttonTextSelected' : '']"> {{ buttonText }}</p>
    </div>
</template>

<script>
export default {
    props: {
        isButtonSelected: Boolean,
        buttonText: String, 
    },
    methods: {
        toggleButtonSelection() {
            this.$emit('toggle-selection', !this.isButtonSelected);
        },
    } 
};
</script>

<style lang="scss"> 

.DashboardNavButton {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: $dimension-default;
    padding: 5px 20px 5px 20px;

    &-icon {
         height: 25px;

    }

    &-text {
        @include font-button-body;
    }
}

.buttonSelected {
    background: paint(squircle);
    --squircle-smooth: 1;
    --squircle-radius: 25px;
    --squircle-fill: black;
}

.buttonTextSelected {
    color: $light;
    font-weight: 600; 
}

</style>