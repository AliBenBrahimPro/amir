class ChatModel {
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  String? id;
  ChatModel(
      {
      this.id,  
      this.name,
      this.icon,
      this.isGroup,
      this.time,
      this.currentMessage,
      this.status,
      this.select = false});
}
