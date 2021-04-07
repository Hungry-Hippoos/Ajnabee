from django.conf.urls import url

from ajnabee.rtest.views.rtest_view import RtestView,RtestAllView,MessageView

urlpatterns = [
    url(r'^api/rtest/all/?$', RtestAllView.as_view(), name='rtest_all'),
    url(r'^api/rtest/(?P<pk>\w+)/?$', RtestView.as_view(), name='rtest'),
    url(r'^api/message/?$', MessageView.as_view(), name='message'),
]