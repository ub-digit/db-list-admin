<template>
<div  v-if="topic" class="topicshow-wrapper">
    <div class="row">
        <div class="col">
          <h1>{{topic.title_en}} / {{topic.title_sv}}</h1>
        </div>
    </div>

    <div class="row">
      <div class="col">
        <div v-show="cannotBeDeleted" class="alert alert-warning" role="alert">
          This topic has subtopics. First remove all subtopics before you can delete this topic.
        </div>
      </div>
    </div>

    <div class="row" v-if="topic.sub_topics && topic.sub_topics.length">
      <div class="col">
        <h2>Subtopics</h2>
        <ul class="list-unstyled">
          <li v-for="sub_topic in topic.sub_topics" :key="sub_topic.id">
            {{sub_topic.title_en}} / {{sub_topic.title_sv}}
          </li>
        </ul>
      </div>
    </div>

    <router-link class="btn btn-primary me-1" :to="{name: 'TopicEdit', params:{ id: topic.id }}">Edit</router-link>
    <a href="#" @click.prevent="removeTopic(topic)" class="btn btn-danger" :class="{disabled: cannotBeDeleted}" >Remove</a>
</div>

</template>

<script>
import { useRoute, useRouter } from 'vue-router'
import { useTopicsStore } from "@/stores/topics"
import { computed } from 'vue'

export default {
  name: 'TopicShow',

  setup() {
    const route = useRoute();
    const router = useRouter();
    const topicsStore = useTopicsStore();
    const topic = computed(() => topicsStore.getTopicById(route.params.id));

    const removeTopic = (topic) => {
      if (confirm("Are you sure?")) {
        topicsStore.removeTopic(topic);
        router.push({name:'index'});
      }
    }

    
    const cannotBeDeleted = computed(() => {
      if (topic.value.sub_topics && topic.value.sub_topics.length) {
        return true;
      }
      return false;
    });

    return {
      topic, 
      removeTopic,
      cannotBeDeleted
    }

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">

</style>
