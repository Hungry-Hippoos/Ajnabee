import logging
import numpy as np
import json
from rest_framework.views import APIView
from rest_framework import renderers
from rest_framework.parsers import JSONParser
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from ajnabee.rtest.services.rtest_test_recommendations import recommend
from ajnabee.rtest.services.rtest_service import get_all_user_data,get_user_data,make_user_instance
from ajnabee.rtest.serializers.rtest_ser import RtestSerializer
from ajnabee.rtest.models import RtestModel
from ajnabee.rtest.services.message_service import sort_data
from sentence_transformers import SentenceTransformer,util
from ajnabee.rtest.services.chat_recommendation import semantic_similarity_roberta

class RtestView(APIView):
    parser_classes = (JSONParser,)
    renderer_classes = (renderers.JSONRenderer,)

    def get(self, request,pk):
        '''
        :params : pk as user_id # username
        '''
        user_data = get_user_data(pk)
        user_data_w_name = user_data.get_opt()
        user_data_recommend = user_data_w_name[1:]
        print("User Data",user_data.get_opt())
        all_user_data = get_all_user_data()
        print("All data ",all_user_data)
        nrows = len(all_user_data)
        print("Number of rows ",nrows)
        X = np.zeros([nrows,11])
        names = []
        for i,users in enumerate(all_user_data):
            names.append(users.get_opt()[0])
            print("User ",users.get_opt()[1:])
            X[i,:] = users.get_opt()[1:]
        print(X)
        self.user_ids,index = recommend(X,X,user_data_recommend,4)
        print("Recommend ",self.user_ids)
        recommended_user_objects = []
        # for user in all_user_data:
        #     print(user.user_id,user_data.user_id)
        #     if user.user_id in self.user_ids:
        #         if user.user_id != user_data.user_id:
        #             recommended_user_objects.append(user)
        usernames = []
        for i in index:
            if names[i] != user_data.username:
                usernames.append(names[i])
                user_rec_final = RtestModel.objects.get(username=names[i])
                recommended_user_objects.append(user_rec_final)
        print(usernames)
        print(recommended_user_objects)
        serializer_data = RtestSerializer(instance=recommended_user_objects,many = True).data
        return Response({'data':serializer_data})
        

class RtestAllView(APIView):
    parser_classes = (JSONParser,)
    renderer_classes = (renderers.JSONRenderer,)

    def post(self, request):
        '''
        POST API to add data
        '''
        print(request.data)
        instance = make_user_instance(request.data)
        try:
            instance.save()
        except:
            raise NotFound(detail="not saved", code=500)
        return Response({'data': "hello"})

    def get(self, request):
        '''
        GET all users data
        '''
        all_user_data = get_all_user_data()
        # print(all_user_data)
        serializer_data = RtestSerializer(instance=all_user_data,many=True).data
        return Response({'data':serializer_data})
        

class MessageView(APIView):
    parser_classes = (JSONParser,)
    renderer_classes = (renderers.JSONRenderer,)

    def post(self, request):
        print(request.data)
        user1,user2 = sort_data(request.data['data'])
        model = SentenceTransformer('paraphrase-distilroberta-base-v1')
        reply = semantic_similarity_roberta(model,[" ".join(user1)],[" ".join(user2)])
        print(reply)
        return Response({'Status':reply})

    '''
    response: 
    {
    "data": [
        "no new number who dis",
        "hi how are ya bruh reply please bitch reply toh kar plrase"
        ]
    }
    '''