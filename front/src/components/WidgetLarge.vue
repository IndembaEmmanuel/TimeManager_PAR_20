<script>
export default {
    props: {
        widgetLargeTitle: String,
    }
}

</script>

<template>
    <div class="WidgetLarge">
        <div class="WidgetLarge__container">
            <h2 class="WidgetLarge__container-title">{{ widgetLargeTitle }}</h2>

            <button class="WidgetLarge__container-button">View all</button> 

        </div>
    </div>
</template>

<style lang="scss">
.WidgetLarge {
    padding: $dimension-default;

    background: paint(squircle);
    --squircle-smooth: 1;
    --squircle-radius: 25px;
    --squircle-fill: #FFFFFF;

    box-shadow: 0px 16px 31px 0px rgba(0, 0, 0, 0.01);

    &__container {
            display: flex;
            justify-content: space-between;
            flex-direction: row;

        &-title {
            font-weight: 500;
            margin: 0;
        }

        &-button {
            all: unset;
            padding: $dimension-tiny $dimension-small;
            transition: all 0.4s ease-in-out;
            background: paint(squircle);
            --squircle-smooth: 1;
            --squircle-radius: 10px;
            --squircle-fill: rgb(111,192,237, 10%);

            cursor: pointer;

            &:hover {
                color: $light;
                --squircle-fill: black; 
                
            }
        }
    }
}
</style>