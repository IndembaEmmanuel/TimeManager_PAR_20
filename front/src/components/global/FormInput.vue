<!-- Script JS -->
<script>
export default {
    props: {
        inputIcon: String,
        textErrorMessage: String,
        isInputTextError: Boolean,
        isPasswordInput: Boolean,
        modelValue: {
            type: String, 
            required: true,
        }
    },

    data() {
        return {
            isShowingPassword: false
        }
    },

    methods: {
        showPassword() {
            this.isShowingPassword = !this.isShowingPassword; 
            this.$emit('isShowingPassword', this.isShowingPassword)

        }
    }
}
</script>

<!-- Template HTML/VUE -->
<template>
    <div class="FormInput__container">
     
        <div class="FormInput__iconContainer"> 

            <img class="FormInput__iconContainer-icon" :src="inputIcon" alt="" v-bind="$attrs">   

            <input 
            :value="modelValue"
            @input="$emit('update:modelValue', $event.target.value)"
            :class="['FormInput__iconContainer-input', isInputTextError ? 'errorBorder' : 'inputBorder']" 
            type="" 
            placeholder="" 
            aria-label="" 
            v-bind="$attrs">

            <img v-if='isPasswordInput' 
            @click="showPassword"
            class="FormInput__iconContainer-iconPassword" 
            :src="isShowingPassword ? 'src/assets/images/ic_eye-open.svg' : 'src/assets/images/ic_eye-closed.svg'" 
            :alt="isShowingPassword ? 'Hide your password' : 'Show your password'"
            > 
            
        </div>
        
        <div v-if="isInputTextError == true" class="FormInput__errorContainer">
            <img class="FormInput__errorContainer-icon" src="/src/assets/images/ic_circle_xmark.svg" alt="Error icon"/>
            <span :value="textErrorMessage"
            @input="$emit('update:textErrorMessage', $event.target.value)" 
            class="FormInput__errorContainer-message">{{ textErrorMessage }}</span>
        </div> 

    </div>
</template>

<!-- Style SCSS -->
<style lang="scss">

.FormInput {
    &__container {
        @include flex-column;
        gap: $dimension-tiny; 

    }

    &__iconContainer {
        position: relative;
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: $dimension-tiny;

        &-icon {
            height: $dimension-medium;
            position: absolute;
            left: $dimension-small; 
        }

        &-iconPassword {
            height: $dimension-medium;
            position: absolute;
            right: $dimension-small; 
            cursor: pointer;
        }

        &-input {
            all: unset;
            padding: $dimension-small $dimension-small $dimension-small $dimension-large;
            width: 100%;
        }
    }

    &__errorContainer {
        display: flex;
        align-items: center;
        flex-direction: row;

        &-message {
            margin-left: $dimension-tiny;
            font-weight: 400;
            font-size: 14px;
            color: $color-error;

        }
    }
}

.errorBorder {
    @include squircle-error;
}

.inputBorder {
   @include squircle-form;
}
</style>