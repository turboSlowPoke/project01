package project01.project01.telegram.rx_objects;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class Message {
    @JsonProperty("message_id")
    private Integer id;
    private TelegramUser from;
    private Integer date;
    private Chat chat;
    @JsonProperty("forward_from")
    private TelegramUser forwardFrom;
    @JsonProperty("forward_from_chat")
    private Chat forwardFromChat;
    @JsonProperty("forward_from_message_id")
    private Integer forwardFromMessageId;
    @JsonProperty("forward_signature")
    private String forwardSignature;
    @JsonProperty("forward_date")
    private Integer forwardDate;
    @JsonProperty("reply_to_message")
    private Message replyToMessage;
    @JsonProperty("edit_date")
    private Integer editDate;
    @JsonProperty("media_group_id")
    private String mediaGroupId;
    @JsonProperty("author_signature")
    private String authorSignature;
    private String text;
    @JsonProperty("entities")
    private List<MessageEntity> messageEntityList;
    @JsonProperty("caption_entities")
    private List<MessageEntity> captionEntities;
    private Audio audio;
    private  Document document;
    private  Game game;
    @JsonProperty("photo")
    private List<PhotoSize> photoSizes;
    private Sticker sticker;
    private Video video;
    private  Voice voice;
    @JsonProperty("video_note")
    private VideoNote videoNote;
    private String caption;
    private Contact contact;
    private  Location location;
    private Venue venue;
    @JsonProperty("new_chat_members")
    private List<TelegramUser> newChatMembers;
    @JsonProperty("left_chat_member")
    private TelegramUser leftChatMember;
    @JsonProperty("new_chat_title")
    private String newChatTitle;
    @JsonProperty("new_chat_photo")
    private List<PhotoSize> newChatPhoto;
    @JsonProperty("delete_chat_photo")
    private Boolean deleteChatPhoto;
    @JsonProperty("group_chat_created")
    private Boolean groupChatCreated;
    @JsonProperty("supergroup_chat_created")
    private Boolean superGroupChatCreated;
    @JsonProperty("channel_chat_created")
    private Boolean channelChatCreated;
    @JsonProperty("migrate_to_chat_id")
    private Integer migrateToChatId;
    @JsonProperty("migrate_from_chat_id")
    private Integer migrateFromChatid;
    @JsonProperty("pinned_message")
    private Message pinnedMessage;
    private Invoice invoice;
    @JsonProperty("successful_payment")
    private SuccessfulPayment successful_payment;
    @JsonProperty("connected_website")
    private String connectedWebsite;

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", from=" + from +
                ", date=" + date +
                ", chat=" + chat +
                ", forwardFrom=" + forwardFrom +
                ", forwardFromChat=" + forwardFromChat +
                ", forwardFromMessageId=" + forwardFromMessageId +
                ", forwardSignature='" + forwardSignature + '\'' +
                ", forwardDate=" + forwardDate +
                ", replyToMessage=" + replyToMessage +
                ", editDate=" + editDate +
                ", mediaGroupId='" + mediaGroupId + '\'' +
                ", authorSignature='" + authorSignature + '\'' +
                ", text='" + text + '\'' +
                ", messageEntityList=" + messageEntityList +
                ", captionEntities=" + captionEntities +
                ", audio=" + audio +
                ", document=" + document +
                ", game=" + game +
                ", photoSizes=" + photoSizes +
                ", sticker=" + sticker +
                ", video=" + video +
                ", voice=" + voice +
                ", videoNote=" + videoNote +
                ", caption='" + caption + '\'' +
                ", contact=" + contact +
                ", location=" + location +
                ", venue=" + venue +
                ", newChatMembers=" + newChatMembers +
                ", leftChatMember=" + leftChatMember +
                ", newChatTitle='" + newChatTitle + '\'' +
                ", newChatPhoto=" + newChatPhoto +
                ", deleteChatPhoto=" + deleteChatPhoto +
                ", groupChatCreated=" + groupChatCreated +
                ", superGroupChatCreated=" + superGroupChatCreated +
                ", channelChatCreated=" + channelChatCreated +
                ", migrateToChatId=" + migrateToChatId +
                ", migrateFromChatid=" + migrateFromChatid +
                ", pinnedMessage=" + pinnedMessage +
                ", invoice=" + invoice +
                ", successful_payment=" + successful_payment +
                ", connectedWebsite='" + connectedWebsite + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public TelegramUser getFrom() {
        return from;
    }

    public void setFrom(TelegramUser from) {
        this.from = from;
    }

    public Integer getDate() {
        return date;
    }

    public void setDate(Integer date) {
        this.date = date;
    }

    public Chat getChat() {
        return chat;
    }

    public void setChat(Chat chat) {
        this.chat = chat;
    }

    public TelegramUser getForwardFrom() {
        return forwardFrom;
    }

    public void setForwardFrom(TelegramUser forwardFrom) {
        this.forwardFrom = forwardFrom;
    }

    public Chat getForwardFromChat() {
        return forwardFromChat;
    }

    public void setForwardFromChat(Chat forwardFromChat) {
        this.forwardFromChat = forwardFromChat;
    }

    public Integer getForwardFromMessageId() {
        return forwardFromMessageId;
    }

    public void setForwardFromMessageId(Integer forwardFromMessageId) {
        this.forwardFromMessageId = forwardFromMessageId;
    }

    public String getForwardSignature() {
        return forwardSignature;
    }

    public void setForwardSignature(String forwardSignature) {
        this.forwardSignature = forwardSignature;
    }

    public Integer getForwardDate() {
        return forwardDate;
    }

    public void setForwardDate(Integer forwardDate) {
        this.forwardDate = forwardDate;
    }

    public Message getReplyToMessage() {
        return replyToMessage;
    }

    public void setReplyToMessage(Message replyToMessage) {
        this.replyToMessage = replyToMessage;
    }

    public Integer getEditDate() {
        return editDate;
    }

    public void setEditDate(Integer editDate) {
        this.editDate = editDate;
    }

    public String getMediaGroupId() {
        return mediaGroupId;
    }

    public void setMediaGroupId(String mediaGroupId) {
        this.mediaGroupId = mediaGroupId;
    }

    public String getAuthorSignature() {
        return authorSignature;
    }

    public void setAuthorSignature(String authorSignature) {
        this.authorSignature = authorSignature;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<MessageEntity> getMessageEntityList() {
        return messageEntityList;
    }

    public void setMessageEntityList(List<MessageEntity> messageEntityList) {
        this.messageEntityList = messageEntityList;
    }

    public List<MessageEntity> getCaptionEntities() {
        return captionEntities;
    }

    public void setCaptionEntities(List<MessageEntity> captionEntities) {
        this.captionEntities = captionEntities;
    }

    public Audio getAudio() {
        return audio;
    }

    public void setAudio(Audio audio) {
        this.audio = audio;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public List<PhotoSize> getPhotoSizes() {
        return photoSizes;
    }

    public void setPhotoSizes(List<PhotoSize> photoSizes) {
        this.photoSizes = photoSizes;
    }

    public Sticker getSticker() {
        return sticker;
    }

    public void setSticker(Sticker sticker) {
        this.sticker = sticker;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public Voice getVoice() {
        return voice;
    }

    public void setVoice(Voice voice) {
        this.voice = voice;
    }

    public VideoNote getVideoNote() {
        return videoNote;
    }

    public void setVideoNote(VideoNote videoNote) {
        this.videoNote = videoNote;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public Contact getContact() {
        return contact;
    }

    public void setContact(Contact contact) {
        this.contact = contact;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Venue getVenue() {
        return venue;
    }

    public void setVenue(Venue venue) {
        this.venue = venue;
    }

    public List<TelegramUser> getNewChatMembers() {
        return newChatMembers;
    }

    public void setNewChatMembers(List<TelegramUser> newChatMembers) {
        this.newChatMembers = newChatMembers;
    }

    public TelegramUser getLeftChatMember() {
        return leftChatMember;
    }

    public void setLeftChatMember(TelegramUser leftChatMember) {
        this.leftChatMember = leftChatMember;
    }

    public String getNewChatTitle() {
        return newChatTitle;
    }

    public void setNewChatTitle(String newChatTitle) {
        this.newChatTitle = newChatTitle;
    }

    public List<PhotoSize> getNewChatPhoto() {
        return newChatPhoto;
    }

    public void setNewChatPhoto(List<PhotoSize> newChatPhoto) {
        this.newChatPhoto = newChatPhoto;
    }

    public Boolean getDeleteChatPhoto() {
        return deleteChatPhoto;
    }

    public void setDeleteChatPhoto(Boolean deleteChatPhoto) {
        this.deleteChatPhoto = deleteChatPhoto;
    }

    public Boolean getGroupChatCreated() {
        return groupChatCreated;
    }

    public void setGroupChatCreated(Boolean groupChatCreated) {
        this.groupChatCreated = groupChatCreated;
    }

    public Boolean getSuperGroupChatCreated() {
        return superGroupChatCreated;
    }

    public void setSuperGroupChatCreated(Boolean superGroupChatCreated) {
        this.superGroupChatCreated = superGroupChatCreated;
    }

    public Boolean getChannelChatCreated() {
        return channelChatCreated;
    }

    public void setChannelChatCreated(Boolean channelChatCreated) {
        this.channelChatCreated = channelChatCreated;
    }

    public Integer getMigrateToChatId() {
        return migrateToChatId;
    }

    public void setMigrateToChatId(Integer migrateToChatId) {
        this.migrateToChatId = migrateToChatId;
    }

    public Integer getMigrateFromChatid() {
        return migrateFromChatid;
    }

    public void setMigrateFromChatid(Integer migrateFromChatid) {
        this.migrateFromChatid = migrateFromChatid;
    }

    public Message getPinnedMessage() {
        return pinnedMessage;
    }

    public void setPinnedMessage(Message pinnedMessage) {
        this.pinnedMessage = pinnedMessage;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public SuccessfulPayment getSuccessful_payment() {
        return successful_payment;
    }

    public void setSuccessful_payment(SuccessfulPayment successful_payment) {
        this.successful_payment = successful_payment;
    }

    public String getConnectedWebsite() {
        return connectedWebsite;
    }

    public void setConnectedWebsite(String connectedWebsite) {
        this.connectedWebsite = connectedWebsite;
    }
}
