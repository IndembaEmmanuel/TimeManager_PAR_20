<script setup>
import DashboardTopBar from '../components/DashboardTopBar.vue'
import WidgetSmall from '../components/WidgetSmall.vue'
import WidgetLarge from '../components/Widgetlarge.vue'
</script>

<template>
    <div class="DashboardContent">
        <DashboardTopBar :fullname="generateFullName()" :role="$store.state.userInfos.role" :initial="generateInitials()" />

        <div class="DashboardContent__widgetsContainer">
            <div class="DashboardContent__widgetHeader">
                <div class="DashboardContent__widgetHeader-datetime">
                    <h1 class="DashboardContent__widgetHeader-datetime--date">{{ formattedDate }}</h1>
                    <p class="DashboardContent__widgetHeader-datetime--hour">{{ updatedTime }}</p>
                </div>

                <Timer :is-timer-starting="isTimerStarting" :timer="'formattedTimer'" @toggle-selection="toggleButton()" />
            </div>

            <div class="DashboardContent__widgetsContainer-small">
                <WidgetSmall v-for="information in widgetSmallInformations" :widget-small-title="information.title"
                    :widget-small-value="information.value" :src="information.image" :alt="information.alt"
                    :color-class="information.color" />
            </div>

            <div class="DashboardContent__widgetsContainer-large">
                <WidgetLarge :widget-large-title="'Analytics'" />
            </div>

        </div>
    </div>
</template>

<script>
import Timer from '../components/global/Timer.vue'

export default {
    data() {
        const commonIsTimerStarting = false
        return {
            isTimerStarting: commonIsTimerStarting,
            arrivalTime: '',
            departureTime: '',
            formattedDate: '',
            updatedTime: '',

            widgetSmallInformations: [
                {
                    title: 'Working times',
                    value: '35:00',
                    image: 'src/assets/images/ic_workingtimes-widget.svg',
                    alt: 'Working times icon',
                    color: '--green'
                },
                {
                    title: 'Overtime work',
                    value: '02:00',
                    image: 'src/assets/images/ic_overtime-widget.svg',
                    alt: 'Overtime icon',
                    color: '--red'
                },
                {
                    title: 'Night hours',
                    value: '01:00',
                    image: 'src/assets/images/ic_moon-widget.svg',
                    alt: 'Moon icon',
                    color: '--purple'
                },
            ]
        }
    },

    mounted() {
        this.updateFormattedDate()
        this.updateTimeEveryMinute()
    },

    methods: {
        generateInitials() {
            const { firstname, lastname } = this.$store.state.userInfos;
            const initials = `${firstname.charAt(0)}${lastname.charAt(0).toLowerCase()}`;
            return initials.toUpperCase();
        },

        generateFullName() {
            const { firstname, lastname } = this.$store.state.userInfos;
            return `${firstname} ${lastname}`;
        },


        updateTimeEveryMinute() {
            this.updateUpdatedTime()

            const now = new Date();
            const seconds = now.getSeconds();

            const millisecondsUntilNextMinute = (60 - seconds) * 1000;

            setTimeout(() => {
                this.updateTimeEveryMinute();
                this.updateUpdatedTime();
            }, millisecondsUntilNextMinute);
        },

        toggleButton() {
            this.isTimerStarting = !this.isTimerStarting;
            this.generateTimestamps()
        },

        generateTimestamps() {
            const timestamp = Date.now()
            if (this.isTimerStarting) {
                this.arrivalTime = new Date(timestamp).toLocaleString();

            } else {
                this.departureTime = Date.now()
                this.departureTime = new Date(timestamp).toLocaleString();
                console.log(this.departureTime)

            }
        },

        updateUpdatedTime() {
            const now = new Date();
            let hours = now.getHours();
            const minutes = now.getMinutes();
            const ampm = hours >= 12 ? 'PM' : 'AM';

            hours = hours % 12 || 12;

            this.updatedTime = `${this.formatDigit(hours)}:${this.formatDigit(minutes)} ${ampm}`;
        },
        formatDigit(value) {
            return value < 10 ? `0${value}` : value;
        },

        updateFormattedDate() {
            const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
            const months = [
                'January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December'
            ];

            const now = new Date();
            const dayOfWeek = daysOfWeek[now.getDay()];
            const month = months[now.getMonth()];
            const dayOfMonth = now.getDate();
            const suffix = this.getDaySuffix(dayOfMonth);

            this.formattedDate = `${dayOfWeek}, ${month} ${dayOfMonth}${suffix}`;
        },
        getDaySuffix(day) {
            if (day >= 11 && day <= 13) {
                return 'th';
            }

            const lastDigit = day % 10;
            switch (lastDigit) {
                case 1:
                    return 'st';
                case 2:
                    return 'nd';
                case 3:
                    return 'rd';
                default:
                    return 'th';
            }
        }
    },
}

</script>

<style lang="scss">
.DashboardContent {
    height: 100vh;
    width: 100%;

    &__widgetsContainer {
        display: flex;
        flex-direction: column;
        background-color: #F9F9F9;
        height: 100%;
        width: 100%;
        border-top-left-radius: 38px;
        padding: $dimension-medium;

        gap: $dimension-medium;
        overflow: scroll;


        &-small {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            grid-gap: $dimension-large;
            border: 1px solid purple;
        }

        &-large {
            width: 100%;
        }
    }

    &__widgetHeader {
        border: 1px solid green;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;

        &-datetime {
            @include flex-column;
            gap: $dimension-tiny;

            &--date {
                margin: 0;
                font-weight: 600;

            }

            &--hour {
                margin: 0;
            }
        }
    }
}
</style>