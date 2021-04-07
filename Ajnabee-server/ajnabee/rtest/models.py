from djutil.models import TimeStampedModel
from django.db.models import PositiveIntegerField, CharField, DateTimeField, TextField, BooleanField
import numpy as np

#RtestModel.objects.create(username = "Manan",q1_opt="1",q2_opt="4",q3_opt="3",q4_opt="1",q5_opt="1",q6_opt="2",q7_opt="4",q8_opt="4",q9_opt="4",q10_opt="3")

class RtestModel(TimeStampedModel):
    username = CharField(max_length=200,blank=False, null=False,primary_key=True)
    user_id = PositiveIntegerField(null=False,blank=False)
    q1_opt = PositiveIntegerField(null=False,blank=False)
    q2_opt = PositiveIntegerField(null=False,blank=False)
    q3_opt = PositiveIntegerField(null=False,blank=False)
    q4_opt = PositiveIntegerField(null=False,blank=False)
    q5_opt = PositiveIntegerField(null=False,blank=False)
    q6_opt = PositiveIntegerField(null=False,blank=False)
    q7_opt = PositiveIntegerField(null=False,blank=False)
    q8_opt = PositiveIntegerField(null=False,blank=False)
    q9_opt = PositiveIntegerField(null=False,blank=False)
    q10_opt = PositiveIntegerField(null=False,blank=False)


    def __str__(self):
        return "{}".format(self.username)

    def get_opt(self):
       return np.array([self.username,self.user_id,self.q1_opt , self.q2_opt , self.q3_opt , self.q4_opt , self.q5_opt,
         self.q1_opt, self.q2_opt, self.q3_opt, self.q4_opt, self.q5_opt ])

    def clean(self):
        '''
        find and clean existing entries for user
        '''
        # data = RtestModel.objects.get(username=pk)
        # if data:
            # print('same obj deleted')
            # self.delete()

    def save(self, *args, **kwargs):
        self.clean()
        super(RtestModel, self).save(*args, **kwargs)
    
    # def __iter__(self):
        # return [ self.user_id, 
        #          self.q1_opt, 
        #          self.q1_opt, 
        #          self.q1_opt, 
        #          self.q1_opt, 
        #          self.q1_opt, 
        #          self.get_rel_to_head_display, 
        #          self.get_disability_display ] 

    # class Meta:
    #     verbose_name_plural = 'User Buffer'
    #     verbose_name = 'User Buffer'


