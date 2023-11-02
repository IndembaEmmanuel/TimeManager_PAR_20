<template>
    <div class="Timer">
        <div class="Timer__container">
            <h2 class="Timer__container-timer">{{isTimerStarting ? 'Stop time tracker' :'Starting time tracker'}}</h2>
            <div @click="toggleButtonSelection" :class="['Timer__container-icon', isTimerStarting ? 'timerSelected' : '']">
                <img class="Time__container-icon--button" :src="[isTimerStarting ? 'src/assets/images/ic_stop.svg' : 'src/assets/images/ic_play.svg']" :alt="[isTimerStarting ? 'Stop icon' : 'Play icon']">
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        isTimerStarting: Boolean,
        timer: String
    },
    methods: {
        toggleButtonSelection() {
            this.$emit('toggle-selection', !this.isTimerStarting);
        },
    } 
}
</script>

<style lang="scss">

.Timer {
    &__container {
        display: flex;
        justify-content: space-between;
        flex-direction: row;
        align-items: center;
        
        align-items: center;
        width: 100%;
        padding: $dimension-default;

        background: paint(squircle);
        --squircle-smooth: 1;
        --squircle-radius: 25px;
        --squircle-fill: white;

        gap: $dimension-default;

        &-timer {
            margin: 0;
            font-weight: 600;
        }

        &-icon {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 90px;
            width: 90px;
            background: paint(squircle);
            --squircle-smooth: 1;
            --squircle-radius: 25px;
            --squircle-fill: #6EBDEE;

            cursor: pointer;            
        }
    }
}

.timerSelected {
    background: paint(squircle);
    --squircle-smooth: 1;
    --squircle-radius: 25px;
    --squircle-fill: black;
}


</style>