<!-- Template HTML/VUE -->
<template>
    <div class="LoginPageIllustration">
        <video class="LoginPageIllustration__video" autoplay loop muted>
            <source src="src/assets/videos/vd_loginpage.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
</template>

<!-- Style SCSS -->
<style lang="scss"> 

.LoginPageIllustration {
    width: 30%;

    @include break-tablet {
        display: none;
    }

    &__video {
        object-fit: cover;
        overflow: hidden;
        max-width: 600px;
        height: 100vh;
    }
}
</style>

<!-- Other Link -->
<!-- https://static.vecteezy.com/system/resources/previews/027/618/313/animated-gradient-motion-background-with-a-light-yellow-cyan-color-combination-free-video.webm -->