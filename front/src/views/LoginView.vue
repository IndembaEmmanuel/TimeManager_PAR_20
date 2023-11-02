<!-- Script JS -->
<script setup>
    import LoginPageIllustration from '../components/login_page/LoginPageIllustration.vue';
    import LoginPageForm from "../components/login_page/LoginPageForm.vue";
    import Alert from "../components/global/Alert.vue";
</script>

<!-- Template HTML/VUE -->
<template>
    <div class="LoginView"> 
        <Alert :alert-title="alertMessage" :is-showing-alert="isShowingAlert"/>
        <div class="LoginView__content">
            <LoginPageIllustration/>
            <LoginPageForm @isShowingAlert="isShowingAlert = $event"  @alertErrorMessage="alertMessage = $event"/>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            isShowingAlert: false,
            alertMessage: ''
        }
    }
}
</script>

<!-- Style SCSS -->
<style lang="scss"> 
.LoginView {
    height: 100vh;
    overflow: hidden;

    &__content {
        display: flex;
        width: 100%;
    }
}
</style>