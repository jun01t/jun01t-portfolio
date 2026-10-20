<template>
    <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="1.5"
        stroke-linecap="round"
        stroke-linejoin="round"
        aria-hidden="true"
        class="ui-arrow"
        :style="{ transform: `rotate(${rotation[direction]}deg)` }"
    >
        <path d="M5 19 19 5M5 5h14v14" />
    </svg>
</template>

<script setup lang="ts">
withDefaults(
    defineProps<{ direction?: 'diagonal' | 'down' | 'down-right' | 'up' }>(),
    {
        direction: 'diagonal',
    },
)
const rotation = { diagonal: 0, down: 135, 'down-right': 90, up: -45 }
</script>

<style scoped>
.ui-arrow {
    display: inline-block;
    width: 1em;
    height: 1em;
    vertical-align: -0.12em;
    flex-shrink: 0;
}
</style>
