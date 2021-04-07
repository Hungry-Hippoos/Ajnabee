from ajnabee.rtest.models import RtestModel

def get_all_user_data():
    all_user_data = RtestModel.objects.all()
    return all_user_data

def get_user_data(pk):
    all_user_data = RtestModel.objects.get(username=pk)
    if not all_user_data:
        return False
    return all_user_data

def make_user_instance(data):
    print("Data ",data['options'])
    instance = RtestModel(
        username = data['username'],
        user_id = 10,
        q1_opt = data['options'][0],
        q2_opt = data['options'][1],
        q3_opt = data['options'][2],
        q4_opt = data['options'][3],
        q5_opt = data['options'][4],
        q6_opt = data['options'][5],
        q7_opt = data['options'][6],
        q8_opt = data['options'][7],
        q9_opt = data['options'][8],
        q10_opt = data['options'][9],
    )
    return instance