<template>
    <div class="shortner-form">
        <div class="form-container">
            <div class="form-content">
                <form v-on:keydown.prevent.enter="go" class="w-full max-w-sm">
                    <div class="flex items-center border-b border-b-2 border-indigo-500">
                        <input v-model="input" class="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none" type="text" placeholder="https://google.com" aria-label="URL">
                        <button @click.prevent="go" class="flex-shrink-0 bg-indigo-500 hover:bg-indigo-700 border-indigo-500 hover:border-indigo-700 text-sm border-4 text-white py-1 px-2 rounded" type="button">
                            Short
                        </button>
                    </div>

                    <div v-show="error" class="bg-red-100 border border-red-400 text-red-700 px-4 py-10 rounded relative" role="alert">
                        <strong class="font-bold">Something went wrong. Please try again</strong>
                        <br>
                        <span class="block sm:inline">{{ error }}</span>
                        <span @click="error = null" class="absolute top-0 bottom-0 right-0 px-4 py-3">
    <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
  </span>
                    </div>

                    <div v-show="url" class="bg-green-100 border border-green-400 text-green-700 px-4 py-10 rounded relative" role="alert">
                        <strong class="font-bold">Your short url is</strong>
                        <br>
                        <span class="block sm:inline">
                            <a :href="url">
                                {{ url }}
                            </a>
                        </span>
                        <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
    <svg @click="url = null" class="fill-current h-6 w-6 text-green-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
  </span>
                    </div>

                </form>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "ShortnerForm",
        data () {
            return {
                input: '',
                url: null,
                error: null
            }
        },
        methods: {
            go() {
                this.url = null;
                this.error = null;

                axios.post('/re', {
                    url: this.input
                })
                    .then(res => {
                        this.url = res.data.data;
                    })
                    .catch(e => {
                        this.error = e.response.data.errors.url[0] || e.response.data.message
                    });
            }
        }
    }
</script>

<style lang="scss" scoped>
    .form {
        &-container {
            width: 100vw;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        &-content {

        }
    }
</style>
