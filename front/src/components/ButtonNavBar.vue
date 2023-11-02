<template>
    <label>
        <div @mouseover="isHovered = true" @mouseleave="isHovered = false" class="ButtonNavBar">
            <img class="ButtonNavBar__icon" :src='isHovered ? image1 : image2' />
            <button class="ButtonNavBar__button" @click="switchComponent(this.componentName)">{{ this.text }}</button>
        </div>
    </label>
</template>

<script>
    export default {
        props: {
            text: String,
            componentName: String,
            switchComponent: Function,
            image1: String,
            image2: String,
            isHovered: {
                type: Boolean,
                default: false
            }
        }
    };

</script>

<style lang="scss">
    .ButtonNavBar {
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        width: 220px;
        height: 55px;
        border-radius: 18px;
        transition: 0.2s;

        &:hover {
            background-color: #000000;
        }

        &:hover &__button {
            color: white;
        }

        &__button {
            position: absolute;
            top: 30%;
            left: 70px;
            background-color: transparent;
            border: 0px;
            color: black;
            transition: 0.2s;
        }

        &__icon {
            position: absolute;
            top: 25%;
            left: 25px;
        }
    }
</style>
  