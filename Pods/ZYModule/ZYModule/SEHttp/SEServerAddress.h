//
//  SEServerAddress.h
//  SkyEmergency
//
//  Created by ZY on 15/10/22.
//  Copyright © 2015年 ZY. All rights reserved.
//  空中急救接口定义

#import <Foundation/Foundation.h>

@interface SEServerAddress : NSObject

/** 注册
 *  up param
 *  	un: 用户名（必填），格式为13/15/14/18开头的11位手机号码
    	im:手机im号
    service_type：业务类型（必填），1代表注册，2代表找回密码
 *  @return
 */
extern NSString * const Register_PHP;

/** 短信验证
 *  up param
 *  	un: 用户名（必填），格式为13/15/14/18开头的11位手机号码
    	im:手机im号(
    	pw: 密码（必填），字符串格式，长度为6-20位
    	pin:短信验证码（必填）
    	ct：客户端类型（必填），1代表android，2代表ios，3代表winphone
    	dv: 设备ID号(可以为空)
    	sim: sim卡号（可以为空）
    	rn : 用户真实姓名(必填)
    	spreader:推广码（可以为空）
 *  @return
 */
extern NSString * const Reg_Sms_Validate_PHP;

/** 重发短信
 *
 *  	un: 手机号码（必填），格式为13/15/14/18开头的11位手机号码
    	im:手机im号
    	service_type：业务类型（必填），1代表注册，2代表找回密码
 *  @return
 */
extern NSString * const Resend_Sms_PHP;

/** 登录
 *  up param
 *  	un：用户名（必填），格式为13/15/14/18开头的11位手机号码
    	pw：密码（必填），字符串格式，长度为6-20位
    	mid：用户的MID。如果是Android设备，则为用户手机号码（非必填）
    	pushsvc：用户的Push Service类型，整数类型（可同时支持多种，按位操作）：（必填）
    1:APNS
    2:LPS
    	ct：客户端类型（必填），1代表andorid、2代表IOS、3代表winphone
 *  @return
 */
extern NSString * const Login_PHP;

/*
 免密登录前发送短信
 	un：用户名（必填），格式为13/15/14/18开头的11位手机号码
 */
extern NSString * const Login_Note_PHP;

/*
 短信验证码登陆
 	un：用户名（必填），格式为13/15/14/18开头的11位手机号码
 	pin：短信验证码（必填）
 	ct：客户端类型（必填），1代表andorid、2代表IOS、3代表winphone
 	mid：用户的MID。如果是Android设备，则为用户手机号码（非必填）
 	pushsvc：用户的Push Service类型，整数类型（可同时支持多种，按位操作）：（必填）
 1:APNS
 2:LPS
 
 */
extern NSString * const Login_Note_Verify_PHP;

/*
    第三方账号登陆
 	weixin_id：第三方账号id（必填）
 	ct：客户端类型（必填），1代表andorid、2代表IOS、3代表winphone
 	mid：用户的MID。如果是Android设备，则为用户手机号码（非必填）
 	pushsvc：用户的Push Service类型，整数类型（可同时支持多种，按位操作）：（必填）
 1:APNS
 2:LPS

 */
extern NSString * const Checkout_Weixin_PHP;

/*
 检查手机号码是否绑定过了  (这一步会发送校验验证码)
 	un：手机号码（必填）
 */
extern NSString * const Checkout_Mobile_PHP;

/*
 绑定第三方账号
 	weixin_id：第三方账号id（必填）
 	un：用户名（必填），格式为13/15/14/18开头的11位手机号码
 	pin：短信验证码（必填）
 	user_name: 微信用户名(必填)
 	ct：客户端类型（必填），1代表andorid、2代表IOS、3代表winphone
 	mid：用户的MID。如果是Android设备，则为用户手机号码（非必填）
 	pushsvc：用户的Push Service类型，整数类型（可同时支持多种，按位操作）：（必填）
 1:APNS
 2:LPS

 */
extern NSString * const Bound_Weixin_PHP;

/**
 *  检查更新
    	lg： OS语言（1为简体中文、2为繁体中文，3为英文，可扩展）（必填）
    	os：OS类型（“android”、“ios”、“win”“android_extend”，可扩展）（必填）
    	cv：客户端当前版本，格式为3字段，如1.0.1、1.1.2、2.0.1（必填）
    flag：0 完整下载包 1 增量下载包
 */
extern NSString * const Check_Update_PHP;

/** 获取个人信息
 *  up param
    	ss：session（必填）
    	piv：个人信息版本号（非必填）
    	uid：获取个人信息的uid（非必填，不填返回自己的个人信息）
 *  @return
 */
extern NSString * const Get_Personal_Info_PHP;

/**
 *  重置密码，即忘记密码
 *  	ot：操作类型，1代表通过手机重设、2代表通过Email重设（必填）
    	fasion：手机号码或Email（必填），手机格式为13/15/14/18开头的11位号码
 *  @return
 */
extern NSString * const Reset_Pw_PHP;

/**
 *  修改密码
 *  	ss：session（必填）
     opw：旧密码
    npw：新密码
 *  @return
 */
extern NSString * const Change_Pw_PHP;

/**
 *  重置密码提交
 *  	ot：操作类型，1代表通过手机进行、2代表通过Email进行
    	fashion：手机号码或email（必填）
    	pin：验证码（必填）
    	pw：重新设置的密码（必填）
 *  @return 
 */
extern NSString * const Reset_Pw_Commit_PHP;

/** 获取消息
    	ss: session值（必填）
 *
 *  @return
 */
extern NSString * const Get_Message_PHP;

/**
 *  确认消息
    	ss: session值（必填）
    	serial: 确认的序号，即当前接收到的最大序号。在服务器端，<= 该序号的消息会被物理删除。（必填）
 *
 *  @return
 */
extern NSString * const Ack_Message_PHP;


/**
 *  发送急救信息
 *
    第一部分：公共参数：
    	ss：session（必填）
    	mime：消息类型，格式：type/subtype（必填）
    	time：时间（必填）
    第二部分：根据mime格式不同，参数表也不同：
    	mime="text/plain"（文字类型的消息）
    	text:消息正文
    	mime=video或audio
    	filename：文件名
    	size：文件大小，单位：byte
    	duration：媒体内容长度，单位：秒
    	file：上传的文件正文
    	id: 消息id
    	mime=image
    	filename：文件名
    	size：文件大小，单位：byte
    	file：上传的文件正文
    	id: 消息id
    	mime=其它（普通文件）
    	filename：文件名
    	size：文件大小，单位：byte
    	file: 上传的文件正文
    	id: 消息id

 *
 *  @return
 */
extern NSString * const Send_SosMsg_PHP;

/**
 *  发送MMS
 *
    第一部分：公共参数：
    	ss：session（必填）
    	uid: 联系人UID (必填),可以为多个，号码之间用英文逗号分隔
    	mime：消息类型，格式：type/subtype（必填）
    	time：时间（必填）
    第二部分：根据mime格式不同，参数表也不同：
    	mime="text/plain"（文字类型的消息）
    	text:消息正文
    	mime=video或audio
    	filename：文件名
    	size：文件大小，单位：byte
    	duration：媒体内容长度，单位：秒
    	file：上传的文件正文
    	id: 消息id
    	mime=image
    	filename：文件名
    	size：文件大小，单位：byte
    	file：上传的文件正文
    	id: 消息id
    	mime=其它（普通文件）
    	filename：文件名
    	size：文件大小，单位：byte
    	file: 上传的文件正文
    	id: 消息id
 *
 *  @return
 */
extern NSString * const Send_Mms_PHP;

#pragma mark -----------用户信息部分-----------

/** 获取头像
    	ss：session（必填）
    	uid: 被获取人的UID (必填)
    	flag：1代表返回缩略图，2代表大图
 */
extern NSString * const Get_Avatar_PHP;

/**
 *  更新图像
 *
    	ss：session（必填）
    	file: 上传的文件    (必填)
 *
 *  @return
 */
extern NSString * const Update_Avatar_PHP;

/** 获取好友版本信息
    	ss：session（必填）
    	flag：1代表按uid返回信息，2代表返回服务器存储的好友信息
    	uid: 联系人UID (若flag为1，则必填，若为2，则不填)，可以多个用英文逗号分割开
 */
extern NSString * const Get_Friends_Version_Info_PHP;

/** 获取好友基本信息
    	ss：session（必填）
    	flag：1代表按uid返回信息，2代表返回服务器存储的好友信息
    	uid: 联系人UID (若flag为1，则必填，若为2，则不填)，可以多个用英文逗号分割开
 */
extern NSString * const Get_Friend_Base_Info_PHP;

/** 获取好友个人信息
    	ss：session（必填）
    	flag: 1,仅获取用户个人基本信息，2,获取用户个人和紧急信息(家庭医生用到)
    	uid：被获取方用户UID
 */
extern NSString * const Get_Friend_Personal_Info_PHP;

/**
 *  变更个人信息
 *
    	ss：session（必填）
    	name：真实姓名（可以为空）
    	sex：性别（可以为空）
    	blood：blood group，血型，格式为编码（可以为空）
    	birthday：出生时间，格式为年月日时，如1978-07-17 09:00:00（可以为空）
    	birth_place：出生地详细地址（可以为空）
    	live_place：现居住地省份，格式为编码（可以为空）
    	live_placeinfo：现居住地其他详细地址（可以为空）
    	clock：是否启动生命时钟，0代表未启动，1代表启动（可以为空）
 *
 *  @return
 */
extern NSString * const Update_Personal_INFO_PHP;

/**
 *  按地区获取医院列表
 *
    	ss：session（必填）
    	section ：区域代码 （必填）
    	type ：代码类型 （0 省代码 1 市代码 2 区代码）（非必填 默认为2）
 *
 *  @return
 */
extern NSString * const Get_Sys_Hospital_Info_PHP;

/**
 *  获取系统广告
 *
 	ss：session（必填）
 	type：广告类型 (必填) 1 急救行动 2 慈善公益 3 软件载入广告 4 文字广告 5 稻跑圈_活动_赛事预告  6 稻跑圈_活动_banner  7 稻跑圈_商场_banner
 *
 *  @return
 */
extern NSString * const Get_Sys_AD_PHP;

/**
 *  上传用户资质图片
 *
    	ss：session（必填）
    	auth：申请类型 格式：2 医生3 健康代表4 志愿者（必填）
    	type：图片类型（1-9数字）（必填）
 *
 *  @return
 */
extern NSString * const Add_User_Auth_Image_Info_PHP;

/**
 *  获取用户资质图片
 *
    	ss：session（必填）
    	auth：申请类型 格式：2 医生3 健康代表4 志愿者（必填）
    	type：图片类型（1-9数字）（必填）
    	userid：要获取的用户ID （必填）
 *
 *  @return
 */
extern NSString * const Get_User_Auh_Image_Info_PHP;

/**
 *  用户资质申请
 *
    	ss：session（必填）
    	auth：申请类型 格式：010000000000 医生 001000000000 健康代表 000100000000 志愿者（必填）
 *
 *  @return
 */
extern NSString * const User_Auth_Apply_PHP;

/**
 *  获取用户申请资质状态
 *
    	ss：session（必填）
 *
 *  @return
 */
extern NSString * const Get_User_Apply_Auth_Info_PHP;

#pragma mark - 失联防范

/**
 *  获取失联人员信息
 *  	ss：session (必填)
 *  @return
 */
extern NSString * const Get_Damoclean_Info_PHP;

/**
 *  获取失联人实时位置信息
 *
    	ss：session（必填）
    	userid ：失联人ID （必填）
    	page：页码（默认为第一页）
 *
 *  @return
 */
extern NSString * const Get_Damoclean_Lbs_Now_PHP;

/**
 *  设置失联联系人f
 *  	ss：session (必填)
 *  	linkman：用户ID（必填）
 *  	Type:0被动监护 1.主动监护 （非必填 默认为被动监护）
 *  	flag：0添加操作 1.删除操作 删除此失联联系人标志，若存在则删除（非必填 默认添加）
 *  @return
 */
extern NSString * const Set_LinkMan_PHP;

/**
 *  获取已设置的失联联系人
 *  	ss：session (必填)
 *  @return
 */
extern NSString * const Get_LinkMan_PHP;

/**
 *  监控人开启监控开关
 *  	ss：session (必填)
    	uid： 被监控用户ID (必填)
    	flag ：0 关闭 1 开启
 *  @return
 */
extern NSString * const Set_On_Off_PHP;

/**
 *  获取好友列表 添加被动监护页面
 *  	ss：session (必填)
*  @return
*/
extern NSString * const Get_LinkMan_Friend_List_New_PHP;

/**
 *  获取好友的坐标信息
 *  	ss：session（必填）
 */
extern NSString * const Get_My_Friends_LBS_PHP;

/**
 *  上传失联人位置信息
 *
    	ss：session（必填）
    	longitude：经度（必填）
    	latitude：纬度（必填）
 *
 *  @return
 */
extern NSString * const Update_LinkGPS_PHP;

/**
 *  更新个人位置信息
 *
    	ss：session（必填）
    	longitude：经度（必填）
    	latitude：纬度（必填）
    	address：地址位置详情（必填）
 *
 *  @return
 */
extern NSString * const Update_My_Location_PHP;

/**
 *  带状态获取好友列表
 *  	ss：session (必填)
 
 *  @return
 */
extern NSString * const Get_LinkMan_Add_Friend_List_PHP;

/**
 *  审批/拒绝监控请求
 *
    	ss：session（必填）
    	uid：主动监控人的id(必填)
    	flag:   1为同意   0为拒绝 (默认为0)
 *
 *  @return
 */
extern NSString * const Set_LinkMan_Request_PHP;

/** 获取救援现场信息列表
 λ	ss: session值（必填）
 λ	flag：数据返回标志 [0 全部 1离我最近 2 我的现场  3 历史现场 4，好友] (必填)
 title_type；（0 救援现场 1 运动动态 2 全部）（必填）
 *  @return
 */
extern NSString * const Get_Rescue_Scene_List_PHP;

/**
 *  获取现场详情
 *  	ss: session值（必填）
      rsid：现场id (必填)
 *  @return
 */
extern NSString * const Get_Rescue_Scene_Info_PHP;

/*  点赞
 λ	ss: session值（必填）
 λ	rs_id:现场ID (必填)
 state:状态（0：取消1：点赞）（必填）
 */
extern NSString * const Create_Rescue_Thumbs_Up_Php;

/**
 *  修改救援现场状态
 *  	ss: session值（必填）
    	rsid:现场ID     (必填)
    	State: 状态默认为0     1  (必填)
 *  @return
 */
extern NSString * const Update_Rescue_Scene_State_PHP;

/**
 *  发布现场信息
 λ	ss: session值（必填）
 λ	title:现场标题（选填）
 λ	ct ：现场内容
 λ	longitude：经度
 λ	latitude：维度
 λ	address: 地址
 λ	upload: 上传图片文件（压缩包）
 λ	title_type: 标题类型（0 救援现场 1 运动动态）（必填）
    auth_type: 权限类型（0 私密 1 好友可见 2 公开）（必填）
 *  @return
 */
extern NSString * const Create_Rescue_Scene_PHP;

/**
 *  追加救援现场描述
 *  	ss: session值（必填）
    	rsid:现场ID     (必填)
    	content: (必填)
 *  @return
 */
extern NSString * const Update_Rescue_Scene_Content_PHP;

/**
 *  上传救援现场图片
 *  	ss: session值（必填）
      rsid：现场id （必填）
    	file: 上传的文件 （必填）
 *  @return
 */
extern NSString * const Upload_Rescue_Scene_IMG_PHP;

/**
 *  上传救援现场图片zip
 *  	ss: session值（必填）
      rsid：现场id （必填）
    	upload: 上传的文件 （必填）
 *  @return
 */
extern NSString * const Upload_Rescue_Scene_IMGZip_PHP;

/**
    发布咨询音频图片问题
 *  	ss：session（必填）
 	cc：问题内容（必填，可以为空）
 	file：zip文件（非必填，文件ID唯一）
 	audiuname：音频文件名称（非必填）
 *
 *  @return
 */
extern NSString * const Create_User_Question_MMS_PHP;

/** 获取用户提问问题列表
    	ss：session（必填）
    	flag：信息筛选标志 0 未解决 1 已解决（必填）
 */
extern NSString * const Get_User_Question_PHP;

/** 获取用户问题多媒体文件
 *  	ss：session（必填）
    	filtype:文件类型（必填）
    	fileid: 文件ID（必填）
    	thumbnail: 1 --请求缩略图2--大图 （必填）
 *
 *  @return
 */
extern NSString * const Get_User_Question_MMS_PHP;

/**
 *  回复用户问题
 *
    	ss：session（必填）
    	uqid: 问题ID （必填）
    	content：回复内容（非必填）
    	file：单文件（音频非必填）
 *
 *  @return
 */
extern NSString * const Answer_Uset_Question_PHP;

/**
 *  设置用户提问
 *
    	ss：session（必填）
    	question_id:问题ID（必填）
    	answer_id: 答案ID（必填）
    	flag: 0 --采纳该回复 1 追问（必填）
    	content:追问内容（非必填）
    	file:音频文件（非必填）
 *
 *  @return
 */
extern NSString * const Set_User_Question_PHP;

/**
 *  获取问题详情及回复列表
 *
    	ss：session（必填）
    	uqid: 问题ID （必填）
 *
 *  @return
 */
extern NSString * const Get_User_Question_Info_PHP;

/**
 *  设置急救卡信息
 *
    	ss：session（必填）
    	height：身高	（必填）
    	weight：体重	（必填）
    	blood：血型	（必填）
    	allergic_drug：	过敏药物	（必填）
    	chronic_disease：慢性病（必填）
    	surgery : 手术史 (必填)
 *
 *  @return
 */
extern NSString * const Set_Rescue_Card_PHP;

/**
 *  设置急救卡联系人信息
 *
    	ss：session（必填）
    	flag：0 添加 1 删除（必填）
    	linkman_id：联系人ID（必填）
 *
 *  @return
 */
extern NSString * const Set_Rescue_Card_LinkMan_PHP;

/**
 *  获取急救卡联系人
 *
    	ss：session（必填）
 *
 *  @return
 */
extern NSString * const Get_Rescue_Card_PHP;

/** 
 *  检查用户是否签约
 *  POST提交。参数表：
    	ss：session（必填）
 */
extern NSString * const Check_User_Signed_PHP;

/** 获取救命稻草文件
 *  	ss：session（必填）
 *
 *  @return
 */
extern NSString * const Get_Super_Power_List_PHP;

/** 获取与用户在系统中有关系的电话信息
 *  	ss：session（必填）
 *
 *  @return
 */
extern NSString * const Get_User_Phone_PHP;

/** 提交通讯录
 *  	ss：session（必填）
 *  	add_number:增加的通信录
    	del_number: 删除的通讯录
 *  @return
 */
extern NSString * const UppB_PHP;

/** 加为医信好友
 *  	cc：认证的内容（第一次调用不用填，若对方要求验证，第二次调用就需要填）
 *  	ss：session（必填）
 *  	ft：好友类型，1代表普通用户）
 *  	uid：需要加为好友的用户UID
 *  @return
 */
extern NSString * const Wish_Add_Friend_PHP;

/** 确认增加好友
    	ss：session（必填）
    	uid：请求加为好友的用户uid
 *  @return
 */
extern NSString * const Confirm_Add_Friend_PHP;

/** 添加好友
 *  	ss：session（必填）
 *  	flag：1代表按uid返回信息，2代表返回服务器存储的好友信息
 *  	uid: 联系人UID (若flag为1，则必填，若为2，则不填)，可以多个用英文逗号分割开
 *  @return
 */
extern NSString * const Get_Friends_Base_Info_PHP;

/** 删除好友
 *  	ss：session（必填）
 *    uid: 联系人UID (必填)，支持多个号码，uid之间用英文逗号隔开。
 *  @return
 */
extern NSString * const Delete_friend_PHP;

/** 获取公益活动列表
 *  	ss：session（必填）
 *  @return
 */
extern NSString * const Get_Public_Welfare_Activity_List_PHP;

/** 获取省份志愿者人数
 *  	ss：session（必填）
 *  @return
 */
extern NSString * const Get_Postulant_Nums_PHP;

/** 获取省份志愿者人数
 *  	ss: session值（必填）
 *    activity_id：活动ID （必填）
 *  @return
 */
extern NSString * const Get_Public_Welfare_Activity_Info_PHP;

/** 设置用户电子围栏
 *  	ss: session值（必填）
 *   uid：用户ID (必填)
 *   ar_msg：围栏信息（必填）
 *  @return
 */
extern NSString * const Set_User_Activity_Range_PHP;

/** 获取用户电子围栏
 *  	ss: session值（必填）
 *   uid：用户ID (必填)
 *  @return
 */
extern NSString * const Get_User_Activity_Range_PHP;

/**
 *  清除被监护人收到的监护请求
 *
 *  	ss：session（必填）
 *
 *  @return
 */
extern NSString * const Clean_Warn_Info_PHP;

/**
 *  银联接口
 *  参数：ss(必填)，id(必填)
 *  @return
 */
extern NSString * const Eg_Union_Tn_Query_PHP;

/**
 *  支付宝接口
 *  参数：ss(必填)，id(必填)
 *  @return
 */
extern NSString * const Eg_Alipay_Sign_PHP;

/**
 *  微信接口
 *  参数：ss(必填)，id(必填)
 *  @return
 */
extern NSString * const Eg_WeiXin_PHP;

/**
 *  发送短信接口
 *  参数：ss(必填))
 *  @return
 */
extern NSString * const Get_Sms_Message_Info_PHP;

/**
 *  获取系统好友排行榜
 *  参数：ss(必填))
 *  @return
 */
extern NSString * const Get_The_Charts_PHP;
/**
 *  获取系统好友排行榜
 *  参数：ss(必填))
 *  @return
 */
extern NSString * const Get_My_Chart_PHP;
/**
 *  获取用户加好友信息
 *  参数：ss(必填))
 *  @return
 */
extern NSString * const Get_User_Add_Friends_info_Php;
/**
 *  删除用户加好友信息
 *  参数：ss(必填))
    	info_id ：加好友信息ID（必填）
 *  @return
 */
extern NSString * const Del_User_Add_Friends_info_Php;
/**
 *  变更好友状态
 *  	ss：session（必填）
 	uid：用户uid
 	flag: 标志位（0 好友变成黑名单 1 黑名单变成好友 )
 *  @return
 */
extern NSString * const Change_My_Friend_State_Php;

/**
 获取现场评论
	ss: session值（必填）
	rsid:现场ID (必填)
**/
extern NSString * const Get_Resue_Scene_Comment_List_Php;

/**
 添加现场评论
 	ss: session值（必填）
 	rsid:现场ID (必填)
 	comment_id ：评论ID（非必填，如不填则视对现场的评论）
 	content: 评论内容(必填)
 **/
extern NSString * const Add_Resue_Scene_Comment_Php;

/**
 获取监控我的人
 	ss: session值（必填）
 **/
extern NSString * const Get_My_Guard_Info_Php;

/**
 发送邮件
 	ss: session值（必填）
 	email (有效邮箱地址)
 **/
extern NSString * const Binding_Mailbox_For_Account_Php;

/**
 获取用户邮箱状态
 	ss: session值（必填）
 **/
extern NSString * const Get_User_Email_Info_State_Php;

/**
 用户每天签到
 	ss: session值（必填）
 **/
extern NSString * const Checkin_Everyday_Php;

/**
 评论目击现场获取积分
 	ss: session值（必填）
 **/
extern NSString * const Get_Comment_Locale_Score_Php;

/**
 用户分享内容获取积分
 	ss: session值（必填）
 **/
extern NSString * const Judge_Whether_Complete_Task_Php;

/**
 *  用户反馈
    ss(用户SESSION)
    content(问题内容)
 */
extern NSString * const Post_Faq_PHP;

/** 申请成为志愿者
 	ss: session值（必填）
 	name: 用户姓名（必填）
 	sex : 用户性别 0未填写  1男  2女（必填）
 	file_a：身份证正面图片（必填）
 	file_b:身份证背面图片（必填）
 	sviui_id :邀请任务id(非必填)
 */
extern NSString * const User_Auth_Apply_Volunteer_Php;

/* 上传志愿者申请界面的医生资质图片
 POST提交，参数表：
 	ss: session值（必填）
 	file_c: 资质图片(必填)
 */
extern NSString * const Upload_Doctor_Aptitude_Image_Php;

/** 获取志愿者申请状态    0 未批复 1 通过 2 拒绝
 *  	ss: session值（必填）
 */
extern NSString * const Get_Volunteer_Apply_State_php;

/** 获取加入和创建的组织
 *  	ss: session值（必填）
    	type 1为获取创建的组织 2为加入的组织

 */
extern NSString * const Get_My_Organizations_Php;

/** 发布公益活动
 	ss: session值（必填）
 	name 活动主题（必填）
 	start_time 活动开始时间（必填）例如  2016-07-07 01
 	finish_time 活动结束时间（必填）例如  2016-07-10 12
 
 	address 活动地点(非必填)   不填为不限地址
 	province 省(非必填)   不填为不限地址
 	city市(非必填)   不填为不限地址
 	area区(非必填)   不填为不限地址
 
 	activity_type 活动类型(必填)
 "1": "农村发展",
 "2": "环保和动保",
 "3": "灾害管理",
 "4": "教育",
 "5": "医疗健康和防艾",
 "6": "文化艺术",
 "7": "气候变化",
 "8": "老人和儿童",
 "9": "残障",
 "10": "法律援助/咨询",
 "11": "企业社会责任",
 "12": "信息网络",
 "13": "城市社区",
 "14": "其他"
 	banner  活动主图(必填)
 	content  活动内容(必填)
 	org_id  发起方组织活动需要选我创建的组织的id，个人活动默认0
 	people_nums 参与人数 类型 number (必填)

 */
extern NSString * const Publish_Public_Service_Activity_Php;

 
/** 获取公益活动分类
 */
extern NSString * const Get_Public_Service_Category_Php;

/** 获取公益活动列表
 	ss: session值（必填）
 	page 分页(非必填) 不穿为第一页
 	province 活动所在省(非必填)
 	area 所在区(非必填)
 	city 所在市(非必填)
 	state 活动状态(非必填) 1招募中3正在进行4已经完成
 	activity_classify  活动类型(非必填)
 	activity_type 活动类型(必填)
 "1": "农村发展",
 "2": "环保和动保",
 "3": "灾害管理",
 "4": "教育",
 "5": "医疗健康和防艾",
 "6": "文化艺术",
 "7": "气候变化",
 "8": "老人和儿童",
 "9": "残障",
 "10": "法律援助/咨询",
 "11": "企业社会责任",
 "12": "信息网络",
 "13": "城市社区",
 "14": "其他"
 */
extern NSString * const Get_Public_Activity_List_Php;

/** 公益活动首页
 *  	ss: session值（必填）
*/
extern NSString * const Public_Service_Index_Php;

/** 获取公益活动详情
 	ss: session值（必填）
 	id: 活动id（必填）
 */
extern NSString * const Get_Public_Activity_Detail_Php;

/** 志愿者积分排行榜
 	ss: session值（必填）
 */
extern NSString * const User_Ranking_List_Score_Php;

/** 积分说明界面信息
 	ss: session值（必填）
 */
extern NSString * const User_Integral_Declare_Php;

/** 获取组织机构列表信息
 	ss: session值（必填）
 */
extern NSString * const Get_All_Apply_Success_Organization_Info_Php;

/** 我创建和参加的公益活动
 	ss: session值（必填）
 */
extern NSString * const My_Public_Service_Php;

/** 报名公益活动
 	ss: session值（必填）
 	id: 活动id（必填）
 	invite_id  邀请码(非必填)

 */
extern NSString * const Join_Public_Activity_Php;

/** 活动完成发布图片
 	ss: session值（必填）
 	id: 活动id（必填）
 	img: 图片文件(必填)
 
 */
extern NSString * const Publish_Activity_Img_Php;

/** 志愿者调用该接口给任务表写记录，后面为完成任务加分用
    	ss: session值（必填）
    	task_id: 任务id（必填）
    当任务id为3时候，需要以下参数：//邀请其他志愿者参与活动
    	activity_id:活动id(必填)
    	invite_userID: 被邀请人id  （必填）
    当任务id为7时候，需要以下参数：  //邀请其他用户参加志愿者
    	invite_userID: : 被邀请人id （必填）

 */
extern NSString * const User_Complete_Task_Interface_Php;


/** 返回活动还能上传几张照片
 	ss: session值（必填）
 	id: 活动id（必填）
 
 */
extern NSString * const Public_Service_Check_Images_Nums_Php;

/** 我的积分界面
 	ss: session值（必填）
 
 */
extern NSString * const Get_My_Add_Score_Recode_List_Php;

/** 活动进行中签到
 	ss: session值（必填）
 	sign_code: 签到码（必填）
 	activity_id: 活动id （必填）
 */
extern NSString * const Public_Service_Chek_Sign_Php;

/** 获取邀请记录
 	ss: session值（必填）
 */
extern NSString * const User_Invite_Recode_List_Php;

/** 返回活动参加的人
 	ss: session值（必填）
 	id活动id（必填）
 */
extern NSString * const Public_Service_Get_Users_Php;

/*  把志愿者踢出活动
 	ss：session（必填）
 	activity_id :活动id(必填)
 	uid  被踢出的志愿者id（必填）
 */
extern NSString * const Kick_Volunteer_Tapeout_Php;

/*
 设置用户开始运动数据
 POST提交。参数表：
 λ	ss：session（必填）
 λ	flag：运动类型（1 跑步 2 骑车 3 登山）
 λ	longitude：开始位置经度（必填）
 λ	latitude：开始位置纬度（必填）
 
 */
extern NSString * const Start_User_Sport_Info_Php;

/*
 设置用户跑步数据
 POST提交。参数表：
 λ	ss：session（必填）
 λ	spid：运动记录ID（必填）
 λ	sport_line ：运动线路（点集合JSON格式）（必填）
 λ	kilometres ：公里数 公里（必填）
 λ	speed ：平均速率 公里/小时（必填）
 λ	kilocalorie ：消耗能量 千卡（必填）
 λ	longitude：终点位置经度（必填）
 λ	latitude：终点位置纬度（必填）
*/
extern NSString * const End_User_Sport_Info_Php;

/*
 设置用户跑步数据
 POST提交。参数表：
 λ	ss：session（必填）
 λ	date:日期，格式:2017-03
 */
extern NSString * const Get_Sport_Day_State_Php;

/*
 获取用户运动数据
 POST提交。参数表：
 λ	ss：session（必填）
 λ	date:日期，格式:2017-03-01
 */
extern NSString * const Get_User_Sport_Info_Php;

/*
 添加用户心率数据
 POST提交。参数表：
 	ss：session（必填）
 	heart_rate：心率数据（bpm）（必填）

 */
extern NSString * const Add_User_Seart_Rate_Info_php;

/*
 按年或者按月统计用户的运动情况
 POST提交。参数表：
 λ	ss：session（必填）
 λ	date:日期，月格式:2017-03   /  年格式：2017（必填）
 λ	flag: 1 跑步(默认)  2 骑车 3 登山(非必填)
 */
extern NSString * const Get_User_Sports_Statistics_Data_Php;

/*今日运动与上次跑步：统计今日运动与上次跑步数据
 POST提交。参数表：
 λ	ss：session（必填）
 sort:排序（1取前三排序，2取所有排序）
 */
extern NSString * const Get_User_Sports_Php;

/*  user_sports_thumbs_up.php
 λ	ss：session（必填）
 λ	friend_id：好友id（必填）
 state:状态（0：取消1：点赞）（必填）
 */
extern NSString * const User_Sports_Thumbs_Up_Php;

/*运动排行点赞消息
 ss：session（必填）
 */
extern NSString * const User_Sports_Thumbs_Up_Message_Php;

/*
 肺活量
 POST提交。参数表：
 	ss：session（必填）
 	vital_capacity：肺活量（CC）（必填）

 */
extern NSString * const Add_User_Vital_Capacity_Info_Php;

/*
 身高体重
 POST提交。参数表：
 	ss：session（必填）
 	weight：体重（kg）（必填）
 	height：身高（cm）（必填）

 */
extern NSString * const Add_User_Weight_Ieight_Info_Php;

/*个人最佳成绩
 ss：session（必填）
 */
extern NSString * const User_Sports_Personal_Best_Php;

/*个人运动记录
 λ	ss：session（必填）（查看是自己记录）
 friend_id：好友id（非必填）（查看好友记录）
 */
extern NSString * const Get_User_Sports_Record_Php;

/*
 我的勋章
 POST提交。参数表：
 	ss：session（必填）
 */
extern NSString * const Get_User_Sports_Medal_php;

/*  获取心率测量记录
 λ	ss：session（必填）
 */
extern NSString * const Get_User_Heart_Rate_Info_Php;

/*  获取肺活量测量记录
 λ	ss：session（必填）
 */
extern NSString * const Get_User_Vital_Capacity_Info_Php;

/*获取身高体重测量记录
 session（必填）
 */
extern NSString * const Get_User_Weight_Height_Day_Php;

/*  获取本周身高体重测量记录
 λ	ss：session（必填）
 */
extern NSString * const Get_User_Weight_Height_Week_Php;

/* 获取月身高体重测量记录
 λ	ss：session（必填）
 λ	date：需要查询的年月（如：2017-03）(非必填，不填查询当月)
 */
extern NSString * const Get_User_Weight_Height_Month_Php;

/*  获取志愿活动列表——健身运动
 λ	ss: session值（必填）
 λ	type:1，我发布的活动2，我参加的活动
 page 分页(非必填) 不传为第一页
 */
extern NSString * const Get_Public_Activity_List_Fitness_Php;

/*  发布志愿活动——健身运动
 λ	ss: session值（必填）
 λ	name 活动主题（必填）
 λ	start_time 活动开始时间（必填）例如  2016-07-07 01
 λ	finish_time 活动结束时间（必填）例如  2016-07-10 12
 
 λ	address 活动地点(非必填)不填为不限地址
 λ	province省(非必填)不填为不限地址
 λ	city市(非必填)不填为不限地址
 λ	area区(非必填)不填为不限地址
 λ	force_open (非必填) 默认0 填1为人数不够也要开启活动
 λ	banner  活动主图(必填)
 λ	content  活动内容(必填)
 λ	org_id  发起方组织活动需要选我创建的组织的id，个人活动默认0
 λ	people_nums 参与人数类型 number (必填)
 phone 非必填
 */
extern NSString * const Publish_Public_Service_Activity_Fitness_Php;

/* 热门回顾——健身运动
   ss: session值（必填）
 */
extern NSString * const Get_Public_Activity_Retrospect_List_Fitness_Php;

/*  获取志愿活动详情——健身运动
 λ	ss: session值（必填）
 id: 活动id（必填）
 */
extern NSString * const Get_Public_Activity_Detail_Fitness_Php;

/*  报名志愿活动——健身运动
 λ	ss: session值（必填）
 id: 活动id（必填）
 */
extern NSString * const Join_Public_Activity_Fitness_Php;

/*  publish_activity_img_fitness.php
 λ	ss: session值（必填）
 λ	id: 活动id（必填）
 文件  img(必填)
 */
extern NSString * const Publish_Activity_Img_Fitness_Php;

/*  获取参加活动人员的群聚状态
 λ	ss：session（必填）
 λ	activity_id：活动id（非必填）（当type为1和2时填写此项，获取自己状态无需填写）
 λ	type: 1：获取自己的状态，2：获取好友的状态，3：获取已参加活动的好友（必填）
 
 返回值说明：
 user_name:好友名称
 image_url:头像
 state：0：无状态，1：发起群聚，2：参加群聚
 my_friends:好友
 no_friends：非好友
 activity_info:活动详情

 注：
 当type为3时
 ①如果只有一位并且状态为1，说明没有除了发起者没有人员参加活动，再次传参type=2获取所有好友的信息与状态
 ②接口会判断是发起者还是参与者，查看已参加活动的人员信息

 */
extern NSString * const Get_User_Cluster_Info_Php;

/*  发布活动信息
 λ	ss：session（必填）
 λ	destination_longitude目的地经度（必填）
 λ	destination_latitude：目的地维度（必填）
 λ	detailed_location：活动详细位置（必填）
 theme：主题（必填）
 */
extern NSString * const Create_Activity_Info_Php;

/*  退出群聚
 λ	ss：session（必填）
 λ	type:1:发起者完成群聚，2：个人退出群聚（必填）3：强制退出群聚
 λ	activity_id：活动id（必填）
 user_id：（非必填）强制退出时需要
 */
extern NSString * const User_Leave_Cluster_Php;

/*  邀请好友参加群聚活动
 λ	ss：session（必填）
 λ	friends_id：好友id(必填)
 activity_id：活动id（必填）
 */
extern NSString * const Invite_Join_Cluster_Php;

/*  确认参加群聚
 λ	ss：session（必填）
 activity_id：活动id（必填）
 */
extern NSString * const Confirm_Join_Cluster_Php;

/*  个人主页
 POST提交。参数表：
 ss：session（必填）
 */
extern NSString * const My_HomePage_Php;

@end
