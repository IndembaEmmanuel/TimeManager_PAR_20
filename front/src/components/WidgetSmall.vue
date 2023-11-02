<script>
export default {
    props: {
        widgetSmallTitle: String,
        widgetSmallValue: String,
        colorClass: String
        
    }
}

</script>

<template>
    <div class="WidgetSmall">
        <div class="WidgetSmall__container">
            <h2 class="WidgetSmall__container-title">{{widgetSmallTitle}}</h2>

            <div class="WidgetSmall__valueContainer">
                <p class="WidgetSmall__valueContainer-value">{{ widgetSmallValue }}</p>
                <div :class="['WidgetSmall__iconContainer', colorClass]"> 
                    <img class="WidgetSmall__iconContainer-icon" src="" alt="" v-bind="$attrs">
                </div>
            </div>
        </div>
    </div>
</template>

<style lang="scss">

.WidgetSmall {
    padding: $dimension-default;

    background: paint(squircle);
    --squircle-smooth: 1;
    --squircle-radius: 25px;
    --squircle-fill: #FFFFFF;

    box-shadow: 0px 16px 31px 0px rgba(0, 0, 0, 0.01);

    &__container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: $dimension-medium;
        &-title {
            font-size: 24px;
            font-weight: 500;
            margin: 0;
        }
    }

    &__valueContainer {
        display: flex;
        align-items: center;
        justify-content: space-between;

        &-value {
            margin: 0;
            font-size: 40px;
            font-weight: 600;
        }
    }

    &__iconContainer {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100px;
        min-width: 100px;
    }
}

.--green {
    background: paint(squircle);
        --squircle-smooth: 1;
        --squircle-radius: 25px;
        --squircle-fill: rgb(61,255,45, 10%);
}
.--red {
    background: paint(squircle);
        --squircle-smooth: 1;
        --squircle-radius: 25px;
        --squircle-fill: rgb(251,85,85, 10%);

}
.--purple {
    background: paint(squircle);
        --squircle-smooth: 1;
        --squircle-radius: 25px;
        --squircle-fill: rgb(180,75,231, 10%);

}
</style>