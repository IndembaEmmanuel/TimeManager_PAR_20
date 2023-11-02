<!-- Script JS -->
<script>
export default {
    props: {
        isShowingAlert: Boolean,
        alertTitle: String,
    },
}
</script>

<!-- Template HTML/VUE -->
<template>
    <section class="Alert" v-if="isShowingAlert">
        <span class="Alert__text">{{ alertTitle }}</span>
    </section>
</template>

<!-- Style SCSS -->
<style lang="scss">
.Alert {
    @include flex-row-center;
    align-items: center;
    width: 100%;
    background-color: black;
    padding: $dimension-small 0;

    &__text {
        color: $light;
        font-size: 15px;
        font-weight: 400;
    }
};
</style>