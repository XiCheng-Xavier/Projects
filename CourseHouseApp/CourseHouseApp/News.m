//
//  News.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "News.h"

@implementation News
@synthesize hotNewsArray;
@synthesize localNewsArray;
-(NSMutableArray *)getHotNewsArray
{
    hotNewsArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:@"《百年孤独》作者马尔克斯逝世" forKey:@"title"];
    [dic1 setValue:@"  墨西哥当地时间4月17日，哥伦比亚著名记者、作家、诺贝尔文学奖获得者加西亚·马尔克斯因病医治无效，在墨西哥城的寓所中溘然长逝，享年87岁。\r\n  加西亚·马尔克斯出生于1927年3月，是当代西班牙语世界最伟大的作家之一，其作品《百年孤独》、《霍乱时期的爱情》在整个世界都享有盛誉，马尔克斯凭借前者获得1982年诺贝尔文学奖，作品被翻译成40多种语言在全球出版，同时也成为了拉丁美洲“魔幻现实主义”集大成者。" forKey:@"passage"];
    [hotNewsArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setValue:@"华润董事长被查" forKey:@"title"];
    [dic2 setValue:@"  昨日，新华社记者王文志通过微博，实名向中纪委举报华润集团董事长宋林渎职。王文志称，宋林在2010年担任华润集团旗下华润电力董事长期间，在收购山西金业集团的事件中涉嫌故意放水，致使数十亿元国有资产流失。" forKey:@"passage"];
    [hotNewsArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setValue:@"董卿赴美产子" forKey:@"title"];
    [dic3 setValue:@"  近日有多家媒体透露，董卿已怀孕4个月，此次赴美是学习和生子两不误。4月16日，董卿首度开腔回应称“暂别央视”属实，但并不是辞职，而是以美国南加州大学访问学者的身份赴美进修，但对于怀孕一事，董卿并未作出正面回应。算上之前在美国诞下一名女婴的“公知女神”柴静，大家感兴趣的是，为啥央视女主持都对赴美产子如此情有独钟？" forKey:@"passage"];
    [hotNewsArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setValue:@"孙杨更换教练" forKey:@"title"];
    [dic4 setValue:@"  今天，发布会上浙江体育职业技术学院宣布，日前，朱志根教练因身体原因，主动向国家体育总局游泳运动管理中心和国家游泳队提出回杭州治疗的申请，国家体育总局游泳运动管理中心和国家游泳队同意朱志根的要求，并经于浙江体育局、浙江体育职业技术学院沟通协商，目前由张亚东负责孙杨的训练工作。" forKey:@"passage"];
    [hotNewsArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setValue:@"雪姨是学霸！王琳曾公费赴苏联大学深造" forKey:@"title"];
    [dic5 setValue:@"  4月23日，雪姨王琳微博自曝曾于24年前公费赴苏联大学深造，并称“我为我是你们中的一份子而感到骄傲”，网友怒赞“雪姨深藏不露”。\r\n因出演《情深深雨蒙蒙》雪姨一角而被众人熟知的实力派演员王琳，4月23日通过微博自曝，曾于1990年公费赴苏联大学进修表演。她发文称“我为我是你们中的一份子而感到骄傲”，并晒出当年国家教育委员会的文件，根据文件，当年共有51人为国家公费赴苏联大学本科生，雪姨王琳在名单中，她所进修的专业是戏剧表演。雪姨微博发布后网友纷纷留言怒赞雪姨深藏不露。" forKey:@"passage"];
    [hotNewsArray addObject:dic5];

    return hotNewsArray;
}

-(NSMutableArray *)getLocalNewsArray
{
    localNewsArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:@"东莞最大鞋厂上千员工罢工为社保维权" forKey:@"title"];
    [dic1 setValue:@"  因社保等纠纷，东莞裕元鞋厂发生大规模停工，位于东莞市高埗镇的裕元鞋厂多个厂区今日(15日)处于停歇状态。\r\n  东莞裕元鞋厂一员工15日接受《第一财经日报》记者采访时称，这次停工维权缘于裕元鞋厂未足额为工人购买社保，按照东莞社保局的规定，工人的社保应包括工伤、养老、医疗、失业及生育保险，社保缴费率规定企业需缴纳员工总收入的11%，员工个人承担8%，而他前不久查了自己的社保缴费，发现工厂只帮他交了他自己所交的部分，但没有缴纳企业应该缴纳的那一部分。" forKey:@"passage"];
    [localNewsArray addObject:dic1];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setValue:@"广州3年73宗跳桥秀" forKey:@"title"];
    [dic2 setValue:@"  17日，广州市政法委通报了近年来广州市的“恶意跳桥”行为，并组织广州市公安局、广州市检察院、广州市法院等职能部门领导及律师代表、高校法律教授、市民代表等数人召开座谈会，请专家市民支招如何减少这种危害公共秩序的行为。据统计，从去年以来，越来越多外省市人员来广州“跳桥”并提出与广州毫无关系的利益诉求。会上有市民提出，跳桥多是“作秀”，为何不效仿“酒驾”的处理办法，严惩“恶意跳桥”。" forKey:@"passage"];
    [localNewsArray addObject:dic2];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setValue:@"广州床租房火爆" forKey:@"title"];
    [dic3 setValue:@"  一种新的房屋出租方式近期在广州登陆并迅速蔓延——“床租房”，即在房屋里放上多张床然后将每一个床位分别出租给不同的租户。在房屋租金高企的背景下，房主们乐于通过这个办法来“创收”，而租客们也想尽量少花点钱多些积蓄去实现梦想，于是各取所需，交易火爆。\r\n羊城晚报记者在对此现象调查中发现，“床租房”的租赁方式多不规范，在房租的诱惑下房主只想多装些床而很少关注其他，有的房屋严重“超载”、有的甚至男女混住只拉一张布帘……安全隐患诸多。" forKey:@"passage"];
    [localNewsArray addObject:dic3];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setValue:@"东莞涉黄酒店老板梁耀辉全国人大代表资格终止" forKey:@"title"];
    [dic4 setValue:@"  全国人大常委会24日表决确认，由广东省选出的十二届全国人大代表，广东奥威斯集团股份有限公司董事长、中源石油集团国际有限公司董事长梁耀辉，因涉嫌刑事犯罪，依照代表法有关规定，全国人大代表资格终止。广东省人大常委会此前决定罢免其代表职务。" forKey:@"passage"];
    [localNewsArray addObject:dic4];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setValue:@"女子26天提供16种证件盖6个章办二胎准生证" forKey:@"title"];
    [dic5 setValue:@"  结婚证、身份证、独生子女证，证证不能缺；单位章、婚育章、居委的章，章章不能漏……“单独二孩”准生证需要哪些手续，流程又是怎样？政策实施近1个月来，不少幸运的市民成功领取了“单独二孩”准生证。昨日，记者就办证流程进行了走访。采访中，准妈妈们异口同声：“办证还是比较繁琐，希望能继续简化流程，为办证者提供方便。”" forKey:@"passage"];
    [localNewsArray addObject:dic5];
    return localNewsArray;
}
@end
