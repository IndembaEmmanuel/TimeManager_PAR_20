<!-- Script JS Setup -->
<script setup> 
import FormInput from "../global/FormInput.vue"
import { initSquircle } from "/src/common/squircle.js"

initSquircle()

</script>

<!-- Template HTML/VUE -->
<template>
    <div class="LoginPageForm">
        <header class="LoginPageForm__header"> 
            <img class="LoginPageForm__header-icon" src="src/assets/images/ic_logo.svg" alt="Logo TimeManager"/>
        </header>

        <div class="LoginPageForm__containerCenter">

            <div class="LoginPageForm__textContainer">
                <h1 class="LoginPageForm__textContainer-title">Welcome <span class="LoginPageForm__textContainer-title--primary">back!</span></h1>
                <p class="LoginPageForm__textContainer-message">Please fill your details to access your account.</p>
            </div>
            
            <div class="LoginPageForm__inputContainer">   
                        <FormInput 
                        :is-input-text-error="isMailErrorMessage" 
                        :input-icon="'src/assets/images/ic_at.svg'"
                        :alt="'Email at icon'"
                        
                        :placeholder="'Mail'" 
                        :type="'email'" 
                        :aria-label="'Enter your mail'" 
                        :text-error-message="'Please enter a valid epitech mail.'"

                        v-model="this.email"
                        />

                        <FormInput 
                        @isShowingPassword="isShowingPassword = $event"

                        :is-input-text-error="isPasswordErrorMessage" 
                        :input-icon="'src/assets/images/ic_lock.svg'"
                        :alt="'Password lock icon'"
                        
                        :placeholder="'Password'" 
                        :type="isShowingPassword ? 'text' : 'password'" 
                        :aria-label="'Enter your password'" 
                        :text-error-message="'Please enter a correct password.'"

                        v-bind:is-password-input="true"
                        v-model="this.password"

                        />
            </div>
            
            <div class="LoginPageForm__buttonContainer"> 
                <button @click="submitForm" class="LoginPageForm__buttonContainer-button"> Sign in</button>
                <p class="LoginPageForm__buttonContainer-message"> If you don't have an account please 
                    <a class="LoginPageForm__buttonContainer-contact" href="mailto:timemanager.contact@gmail.com">contact the support</a>
                </p>
            </div>
            
        </div>  
    </div>
</template>

<!-- Script JS -->
<script>

export default {
    data() {
        return {
            email: '',
            password: '',
            isMailErrorMessage: false,
            isPasswordErrorMessage: false,
            isShowingPassword: false
        };
    },

    methods: {
        submitForm() {
            if (this.email.includes("@epitech.eu") === true && this.password != '') {
                this.login()
            } else if (!this.email.includes('@epitech.eu')) {
                this.isMailErrorMessage = true,
                this.$emit('isShowingAlert', true);
                this.$emit('alertErrorMessage', 'Please enter a valid epitech email.');

            } else {
                this.isPasswordErrorMessage = true,
                this.$emit('isShowingAlert', true);
                this.$emit('alertErrorMessage', 'Please enter a valid password.');
            }
        },

        login: function () {
            this.$store.dispatch('login', {
                email: this.email,
                password: this.password,
                
            }).then((response) => {
                console.log(response)
                this.$router.push("/dashboard") 
                
            }).catch((error) => { 
                this.isMailErrorMessage = true
                this.isPasswordErrorMessage = true
                this.$emit('isShowingAlert', true);
                this.$emit('alertErrorMessage', error.response.data.error + '.');
                
            });
        }
    }
}
</script>

<!-- Style SCSS -->
<style lang="scss"> 

.LoginPageForm {
    @include flex-column-center;
    align-items: center;
    background-color: white;
    width: 70%;

    @include break-tablet {
        width: 100%;
        height: 100vh;
    }
    
    &__header {
        display: flex;
        justify-content: end;
        width: 100%;

        @include break-tablet {
            justify-content: center;
        }

        &-icon{
            width: 180px;
            margin: $dimension-default $dimension-large $dimension-none $dimension-none;

            @include break-tablet {
                margin-right: $dimension-none;
            }
        }
    }

    &__containerCenter{
        @include flex-column-center;
        height: 100vh;
        width: 50%;
        padding-bottom: $dimension-large;

        @include break-mobile {
            width: 80%;
        }
    }

    &__textContainer {
        &-title{
            @include font-title2;
        
            &--primary{
                color: $color-primary; 
            }
        }

        &-message {
            margin-top: $dimension-none;
        }
    }

    &__inputContainer {
        @include flex-column;
        gap: $dimension-tiny; 
    }

    &__buttonContainer {
        @include flex-column-center;
        width: 100%; 
        margin-top: $dimension-medium;

        &-button {
            @include font-button-body;
            cursor: pointer;
            width: 100%; 
            padding: $dimension-default;
            color: black; 
            border: none; 
            transition: all 0.4s ease-in-out;
            background: paint(squircle);
            --squircle-smooth: 1;
            --squircle-radius: 25px;
            --squircle-fill: #6EBDEE; 

            &:hover {
                color: $light;
                --squircle-fill: black; 
                
            }
        } 

        &-message {
            @include font-caption;
        }

        &-contact {
            color: black; 
            font-weight: 400;
        }
    }
}
</style>