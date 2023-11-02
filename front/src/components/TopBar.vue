<script>
    export default {
        data() {
            return {
                user: null,
            };
        },
        mounted() {
            this.loadUser();
        },
        methods: {
            async loadUser() {
                const response = await this.$apiServices.getUser();
                this.user = response;
            },
        },
    };
</script>

<template>
    <div class="TopBar">
        <div class="TopBar__topContainer">
            <img class="TopBar__logo" src="/src/assets/images/ic_logo.svg">
        </div>
        <div class="TopBar__userContainer">
            <div class="TopBar__userInfo">
                <p v-if="user" class="TopBar__userText">{{ this.user.email }} {{ this.user.username }}</p>
                <p v-if="user" class="TopBar__userText">Role</p>
            </div>
            <p class="TopBar__iconProfile" />
        </div>
    </div>
</template>

<style lang="scss">
.TopBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 120px;
    background-color: $light;
    margin: $dimension-none $dimension-large;

    &__topContainer {
        display: flex;
        align-items: center;

        @include break-mobile {
            width: fit-content;
            flex-direction: column;
            margin-top: 10px;
            height: 60px;
            align-items: end;
            margin-left: 35px;
        }
    }

    &__logo {
        width: 200px;
        height: 50px;
        // transition: 1s;

        @include break-tablet {
            width: 175px;
            height: 48px;
            margin-left: 75px;
        }

        @include break-mobile {
            width: 135px;
            height: 40px;
            margin: 0px;
        }
    }

    &__textFont {
        font-size: 25px;
        font-weight: bold;
        // transition: 0.5s;

        @include break-tablet {
            font-size: 20px;
        }

        @include break-mobile {
            font-size: 15px;
        }
    }

    &__userContainer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-right: 125px;
        // transition: 0.5s;

        @include break-tablet {
            margin-right: 75px;
        }

        @include break-mobile {
            margin-right: 35px;
        }
    }

    &__userInfo {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: flex-end;
        margin-right: 30px;
        padding: 7px 0px 7px 0px;
        height: 75px;
        width: 150px;
        // transition: 0.5s;

        @include break-tablet {
            margin-right: 20px;
            height: 60px;
        }
    }
    
    &__userText {
        height: 25px;
        margin: 0px;
        font-size: 15px;
        // transition: 0.5s;

        @include break-mobile {
            height: 20px;
            font-size: 13px;
        }
    }

    &__iconProfile {
        width: 70px;
        height: 70px;
        background-color: #C4C4C4;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 25px;
        font-weight: bold;
        // transition: 0.5s;

        @include break-mobile {
            width: 50px;
            height: 50px;
            font-size: 20px;
        }
    }
}
</style>