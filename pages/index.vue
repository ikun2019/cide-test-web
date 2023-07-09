<template>
  <div>
    <h1>Todo</h1>
    <div>
      <input type="text" name="todo" id="todo" v-model="todo">
      <button type="submit" @click.prevent="createTodo">投稿</button>
    </div>
    <div>
      <ul v-for="(todo, index) in todos" :key="index">
        <li>{{ todo.title }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      todo: '',
      todos: []
    }
  },
  mounted() {
    this.fetchTodos()
  },
  methods: {
    async fetchTodos() {
      try {
        const response = await this.$axios.$get(`${process.env.API_URL}/api`);
        this.todos = response.todos;
      } catch (err) {
        console.error(err);
      }
    },
    async createTodo() {
      try {
        const data = {
          todo: this.todo
        };
        const response = await this.$axios.$post(`${process.env.API_URL}/api`, data);
        this.todo = '';
        this.fetchTodos();
        this.$router.push('/');
      } catch (err) {
        console.error(err);
      }
    }
  }
}
</script>
