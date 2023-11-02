export function initSquircle() {
    if ("paintWorklet" in CSS) {
        CSS.paintWorklet.addModule(
            "https://www.unpkg.com/css-houdini-squircle/squircle.min.js"
        );
    }
};