import { defineStore } from "pinia";
import NProgress from 'nprogress';
import _ from 'lodash'; 

export const useTopicsStore = defineStore({
  id: "topics",
  state: () => {
    return {
        topics:  [
          {
            id: 1,
            title_sv: "Ekonomi",
            title_en: "Economy",
            sub_topics: [
              {
                id:21, 
                title_sv: "Ekonomi sub 21",
                title_en: "Economy sub 21",
                can_be_removed: false 
              },
              {
                id:22, 
                title_sv: "Ekonomi sub 22",
                title_en: "Economy sub 22",
                can_be_removed: false
              },
              {
                id:23, 
                title_sv: "Ekonomi sub 23",
                title_en: "Economy sub 23",
                can_be_removed: true
              }
            ]
          },
          {
            id: 2,
            title_sv: "Gender studies sv 23",
            title_en: "Gender studies 23",
            sub_topics:[]
          },
          {
            id: 3,
            title_sv: "Teknologi",
            title_en: "Technology",
            sub_topics:[]
          },
        ]
  
      } 
  
  },
  getters: {
    getTopicById: (state) => (id) => {
        try {
          return state.topics.find((topic) => topic.id === parseInt(id) );
        } catch (err) {
          console.log(err.message);
        }
      }
  },
  actions: {
// ##################### FAKE API CALLS ############# 
    fakeApiCallNewTopicReject(payload) {
      return new Promise((_, reject) => {
        setTimeout(() =>
            reject({
              topic: 'Error while saving',
              sub_topics: ['error1', 'error2']
            }),
          1000
        )
      })
    },
    fakeApiCallNewTopicResolve(payload) {
      return new Promise((resolve, _) => {
        setTimeout(() => {
          payload.id = Date.now();
          payload.sub_topics.forEach(topic => topic.id = Date.now())
          this.topics.push(payload)
          return resolve(payload)
        },
          1000
        )
      })
    },
// #################### END FAKE API CALLS ###########

    waitFor(ms) {
      return new Promise((r) => setTimeout(r, ms));
    },    
    removeTopic(payload) {
        try {
            this.topics.splice(this.topics.indexOf(payload), 1)
        } catch (err)  {
          console.log(err.message)
        }
    },
    async updateTopic(payload) {
        try {
           //await this.fakeApiCall(payload)
            // http://shzhangji.com/blog/2018/04/17/form-handling-in-vuex-strict-mode/
            var obj = this.topics.find(item => item.id === payload.id);
            if (obj) {
                _.assign(obj,payload);
            }
        } catch (inputErrors) {
            if (inputErrors) {
              console.log(`backend error: ${ inputErrors}` );
              return inputErrors;
            }
        }
    },
    async newTopic(payload) {
      try {
        NProgress.start();
        await this.fakeApiCallNewTopicResolve(payload);
      } catch (inputErrors) {
        if (inputErrors) {
          console.log('backend errors:',inputErrors);
          return inputErrors;
        }
      } finally {
        NProgress.done();
      }
    }
  }
});
