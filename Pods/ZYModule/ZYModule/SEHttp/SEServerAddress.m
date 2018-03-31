//
//  SEServerAddress.m
//  SkyEmergency
//
//  Created by ZY on 15/12/14.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEServerAddress.h"

@implementation SEServerAddress

NSString * const Register_PHP                           = @"register.php";

NSString * const Reg_Sms_Validate_PHP                   = @"reg_sms_validate.php";

NSString * const Resend_Sms_PHP                         = @"resend_sms.php";

NSString * const Login_PHP                              = @"login.php";

NSString * const Login_Note_PHP                         = @"login_note.php";

NSString * const Login_Note_Verify_PHP                  = @"login_note_verify.php";

NSString * const Checkout_Weixin_PHP                    = @"checkout_weixin.php";

NSString * const Checkout_Mobile_PHP                    = @"checkout_mobile.php";

NSString * const Bound_Weixin_PHP                       = @"bound_weixin.php";

NSString * const Check_Update_PHP                       = @"check_update.php";

NSString * const Get_Personal_Info_PHP                  = @"get_personal_info.php";

NSString * const Reset_Pw_PHP                           = @"reset_pw.php";

NSString * const Change_Pw_PHP                          = @"change_pw.php";

NSString * const Reset_Pw_Commit_PHP                    = @"reset_pw_commit.php";

NSString * const Get_Message_PHP                        = @"get_message.php";

NSString * const Ack_Message_PHP                        = @"ack_message.php";

NSString * const Send_SosMsg_PHP                        = @"send_sosmsg.php";

NSString * const Send_Mms_PHP                           = @"send_mms.php";

NSString * const Get_Avatar_PHP                         = @"get_avatar.php";

NSString * const Update_Avatar_PHP                      = @"update_avatar.php";

NSString * const Get_Friends_Version_Info_PHP           = @"get_friends_version_info.php";

NSString * const Get_Friend_Base_Info_PHP               = @"get_friends_base_info.php";

NSString * const Get_Friend_Personal_Info_PHP           = @"get_friend_personal_info.php";

NSString * const Update_Personal_INFO_PHP               = @"update_personal_info.php";

NSString * const Get_Sys_Hospital_Info_PHP              = @"get_sys_hospital_info.php";

NSString * const Get_Sys_AD_PHP                         = @"get_sys_ad.php";

NSString * const Add_User_Auth_Image_Info_PHP           = @"add_user_auth_images_info.php";

NSString * const Get_User_Auh_Image_Info_PHP            = @"get_user_auth_images_info.php";

NSString * const User_Auth_Apply_PHP                    = @"user_auth_apply.php";

NSString * const Get_User_Apply_Auth_Info_PHP           = @"get_user_apply_auth_info.php";

NSString * const Get_Damoclean_Info_PHP                 = @"get_damoclean_info.php";

NSString * const Get_Damoclean_Lbs_Now_PHP              = @"get_damoclean_lbs_now.php";

NSString * const Set_LinkMan_PHP                        = @"set_linkman.php";

NSString * const Get_LinkMan_PHP                        = @"get_linkman.php";

NSString * const Set_On_Off_PHP                         = @"set_on_off.php";

NSString * const Get_LinkMan_Friend_List_New_PHP        = @"get_linkman_friend_list_new.php";

NSString * const Get_My_Friends_LBS_PHP                 = @"get_my_friends_lbs.php";

NSString * const Update_LinkGPS_PHP                     = @"update_linkGPS.php";

NSString * const Update_My_Location_PHP                 = @"update_my_location.php";

NSString * const Get_LinkMan_Add_Friend_List_PHP        = @"get_linkman_add_friend_list.php";

NSString * const Set_LinkMan_Request_PHP                = @"set_linkman_request.php";

NSString * const Get_Rescue_Scene_List_PHP              = @"get_rescue_scene_list.php";

NSString * const Get_Rescue_Scene_Info_PHP              = @"get_rescue_scene_info.php";

NSString * const Create_Rescue_Thumbs_Up_Php            = @"create_rescue_thumbs_up.php";

NSString * const Update_Rescue_Scene_State_PHP          = @"update_rescue_scene_state.php";

NSString * const Create_Rescue_Scene_PHP                = @"create_rescue_scene.php";

NSString * const Update_Rescue_Scene_Content_PHP        = @"update_rescue_scene_content.php";

NSString * const Upload_Rescue_Scene_IMG_PHP            = @"upload_rescue_scene_img.php";

NSString * const Upload_Rescue_Scene_IMGZip_PHP         = @"upload_rescue_scene_imgzip.php";

NSString * const Create_User_Question_MMS_PHP           = @"create_user_question_mms.php";

NSString * const Get_User_Question_PHP                  = @"get_user_question.php";

NSString * const Get_User_Question_MMS_PHP              = @"get_user_question_mms.php";

NSString * const Answer_Uset_Question_PHP               = @"answer_user_question.php";

NSString * const Set_User_Question_PHP                  = @"set_user_question.php";

NSString * const Get_User_Question_Info_PHP             = @"get_user_question_info.php";

NSString * const Set_Rescue_Card_PHP                    = @"set_rescue_card.php";

NSString * const Set_Rescue_Card_LinkMan_PHP            = @"set_rescue_card_linkman.php";

NSString * const Get_Rescue_Card_PHP                    = @"get_rescue_card.php";

NSString * const Check_User_Signed_PHP                  = @"check_user_signed.php";

NSString * const Get_Super_Power_List_PHP               = @"get_super_power_list.php";

NSString * const Get_User_Phone_PHP                     = @"get_user_phone.php";

NSString * const UppB_PHP                               = @"uppb.php";

NSString * const Wish_Add_Friend_PHP                    = @"wish_add_friend.php";

NSString * const Confirm_Add_Friend_PHP                 = @"confirm_add_friend.php";

NSString * const Get_Friends_Base_Info_PHP              = @"get_friends_base_info.php";

NSString * const Delete_friend_PHP                      = @"delete_friend.php";

NSString * const Get_Public_Welfare_Activity_List_PHP   = @"get_public_welfare_activity_list.php";

NSString * const Get_Postulant_Nums_PHP                 = @"get_postulant_nums.php";

NSString * const Get_Public_Welfare_Activity_Info_PHP   = @"get_public_welfare_activity_info.php";

NSString * const Set_User_Activity_Range_PHP            = @"set_user_activity_range.php";

NSString * const Get_User_Activity_Range_PHP            = @"get_user_activity_range.php";

NSString * const Clean_Warn_Info_PHP                    = @"clean_warn_info.php";

NSString * const Eg_Union_Tn_Query_PHP                  = @"eg_union_tn_query.php";

NSString * const Eg_WeiXin_PHP                          = @"eg_weixin.php";

NSString * const Eg_Alipay_Sign_PHP                     = @"eg_alipay_sign.php";

NSString * const Get_Sms_Message_Info_PHP               = @"get_sms_message_info.php";

NSString * const Get_The_Charts_PHP                     =  @"get_the_charts.php";

NSString * const Get_My_Chart_PHP                       =  @"get_my_chart.php";

NSString * const Get_User_Add_Friends_info_Php          = @"get_user_add_friends_info.php";

NSString * const Del_User_Add_Friends_info_Php          = @"del_user_add_friends_info.php";

NSString * const Change_My_Friend_State_Php             = @"change_my_friend_state.php";

NSString * const Get_Resue_Scene_Comment_List_Php       = @"get_rescue_scene_comment_list.php";

NSString * const Add_Resue_Scene_Comment_Php            = @"add_rescue_scene_comment.php";

NSString * const Get_My_Guard_Info_Php                  = @"get_my_guard_info.php";

NSString * const Binding_Mailbox_For_Account_Php        = @"binding_mailbox_for_account.php";

NSString * const Get_User_Email_Info_State_Php          = @"get_user_email_info_state.php";

NSString * const Checkin_Everyday_Php                   = @"checkin_everyday.php";

NSString * const Get_Comment_Locale_Score_Php           = @"get_comment_locale_score.php";

NSString * const Judge_Whether_Complete_Task_Php        = @"judge_whether_complete_task.php";

NSString * const Post_Faq_PHP                           = @"post_faq.php";

NSString * const User_Auth_Apply_Volunteer_Php          = @"user_auth_apply_volunteer.php";

NSString * const Upload_Doctor_Aptitude_Image_Php       = @"upload_doctor_aptitude_image.php";

NSString * const Get_Volunteer_Apply_State_php          = @"get_volunteer_apply_state.php";

NSString * const Get_My_Organizations_Php               = @"get_my_organizations.php";

NSString * const Publish_Public_Service_Activity_Php    = @"publish_public_service_activity.php";

NSString * const Get_Public_Service_Category_Php        = @"get_public_service_category.php";

NSString * const Get_Public_Activity_List_Php           = @"get_public_activity_list.php";

NSString * const Public_Service_Index_Php               = @"public_service_index.php";

NSString * const Get_Public_Activity_Detail_Php         = @"get_public_activity_detail.php";

NSString * const User_Ranking_List_Score_Php            = @"user_ranking_list_score.php";

NSString * const User_Integral_Declare_Php              = @"user_integral_declare.php";

NSString * const Get_All_Apply_Success_Organization_Info_Php = @"get_all_apply_success_organization_info.php";

NSString * const My_Public_Service_Php                  = @"my_public_service.php";

NSString * const Join_Public_Activity_Php               = @"join_public_activity.php";

NSString * const Publish_Activity_Img_Php               = @"publish_activity_img.php";

NSString * const User_Complete_Task_Interface_Php       = @"user_complete_task_interface.php";

NSString * const Public_Service_Check_Images_Nums_Php   = @"public_service_check_images_nums.php";

NSString * const Get_My_Add_Score_Recode_List_Php       = @"get_my_add_score_recode_list.php";

NSString * const Public_Service_Chek_Sign_Php           = @"public_service_chek_sign.php";

NSString * const User_Invite_Recode_List_Php            = @"user_invite_recode_list.php";

NSString * const Public_Service_Get_Users_Php           = @"public_service_get_users.php";

NSString * const Kick_Volunteer_Tapeout_Php             = @"kick_volunteer_tapeout.php";

NSString * const Start_User_Sport_Info_Php              = @"start_user_sport_info.php";

NSString * const End_User_Sport_Info_Php                = @"end_user_sport_info.php";

NSString * const Get_Sport_Day_State_Php                = @"get_sport_day_state.php";

NSString * const Get_User_Sport_Info_Php                = @"get_user_sport_info.php";

NSString * const Add_User_Seart_Rate_Info_php           = @"add_user_heart_rate_info.php";

NSString * const Get_User_Sports_Statistics_Data_Php    = @"get_user_sports_statistics_data.php";

NSString * const Get_User_Sports_Php                    = @"get_user_sports.php";

NSString * const User_Sports_Thumbs_Up_Php              = @"user_sports_thumbs_up.php";

NSString * const User_Sports_Thumbs_Up_Message_Php      = @"user_sports_thumbs_up_message.php";

NSString * const Add_User_Vital_Capacity_Info_Php       = @"add_user_vital_capacity_info.php";

NSString * const Add_User_Weight_Ieight_Info_Php        =
@"add_user_weight_height_info.php";

NSString * const User_Sports_Personal_Best_Php          = @"user_sports_personal_best.php";

NSString * const Get_User_Sports_Record_Php             = @"get_user_sports_record.php";

NSString * const Get_User_Sports_Medal_php              = @"get_user_sports_medal.php";

NSString * const Get_User_Heart_Rate_Info_Php           = @"get_user_heart_rate_info.php";

NSString * const Get_User_Vital_Capacity_Info_Php       = @"get_user_vital_capacity_info.php";

NSString * const Get_User_Weight_Height_Day_Php         = @"get_user_weight_height_day.php";

NSString * const Get_User_Weight_Height_Week_Php        = @"get_user_weight_height_week.php";

NSString * const Get_User_Weight_Height_Month_Php       = @"get_user_weight_height_month.php";

NSString * const Get_Public_Activity_List_Fitness_Php   = @"get_public_activity_list_fitness.php";

NSString * const Publish_Public_Service_Activity_Fitness_Php = @"publish_public_service_activity_fitness.php";

NSString * const Get_Public_Activity_Retrospect_List_Fitness_Php = @"get_public_activity_retrospect_list_fitness.php";

NSString * const Get_Public_Activity_Detail_Fitness_Php = @"get_public_activity_detail_fitness.php";

NSString * const Join_Public_Activity_Fitness_Php       = @"join_public_activity_fitness.php";

NSString * const Publish_Activity_Img_Fitness_Php       = @"publish_activity_img_fitness.php";

NSString * const Get_User_Cluster_Info_Php              = @"get_user_cluster_info.php";

NSString * const Create_Activity_Info_Php               = @"create_activity_info.php";

NSString * const User_Leave_Cluster_Php                 = @"user_leave_cluster.php";

NSString * const Invite_Join_Cluster_Php                = @"lnvite_join_cluster.php";

NSString * const Confirm_Join_Cluster_Php               = @"confirm_join_cluster.php";

NSString * const My_HomePage_Php                        = @"my_homepage.php";

@end
