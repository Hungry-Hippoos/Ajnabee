
def get_usernames(data):
    usernames = set()
    for message in data:
        usernames.add(message[1])
    usernames = list(usernames)
    return usernames

def divide_data(usernames,data):
    user1=[]
    user2=[]
    for message in data:
        if usernames[0] == message[1]:
            user1.append(message[0])
        else:
            user2.append(message[0])
    return user1,user2

def sort_data(request):
    usernames = get_usernames(request)
    user1,user2 = divide_data(usernames,request)
    print(user1,user2)
    return user1,user2


# request = {"data":[["hi","jimmy",1617481474987],["how are ya","jimmy",1617481478949],["bruh","jimmy",1617481481664],["reply please","jimmy",1617481485196],["no","mamba",1617481560656],["new number","mamba",1617481584508],["who dis","mamba",1617481587492],["bitch","jimmy",1617481634632],["reply toh kar","jimmy",1617486586990],["plrase","jimmy",1617486589319]]}

# sort_data(request["data"])