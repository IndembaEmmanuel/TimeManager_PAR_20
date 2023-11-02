<script>
export default {
    props: {
        fullname: String,
        role: String,
        initial:String
    }
}
</script>

<template>
    <header class="DashboardTopBar"> 
        <div class="DashboardTopBar__information">
            <p class="DashboardTopBar__information-name"> {{ fullname }}</p>
            <p class="DashboardTopBar__information-job"> {{ role }}</p>
        </div>

        <div class="DashboardTopBar__picture">
            <p class="DashboardTopBar__picture-name"> {{ initial }} </p>
        </div>
    </header>

</template>

<style lang="scss">

.DashboardTopBar {
    display: flex;
    align-items: center;
    justify-content: end;
    padding: $dimension-medium $dimension-default;
    height: 104px;
    gap: $dimension-default;
    border: 2px solid blue;

    &__information {
        @include flex-column;
        gap: $dimension-tiny;

        &-name {
            margin: 0;
            font-weight: 600;
        }

        &-job {
            margin: 0;
            font-size: $caption;
            color: rgba($color: #000000, $alpha: 0.4);
        }
    }

    &__picture {

        display: flex;
        justify-content: center;
        align-items: center;
        background-color: $color-primary;
        height: 60px;
        width: 60px;
        border-radius: 100%;

        &-name {
            color: $light;
            font-size: 24px;
            font-weight: 600;
        }
    }
}


</style>