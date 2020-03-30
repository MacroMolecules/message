class Ids {
  static const String titleHome = 'title_home';
  static const String titleProject = 'title_Project';
  static const String titleDynamic = 'title_dynamic';
  static const String titleSystem = 'title_system';

  static const String titleBookmarks = 'title_bookmarks';
  static const String titleCollect = 'title_collect';
  static const String titleSetting = 'title_setting';
  static const String titleAbout = 'title_about';
  static const String titleShare = 'title_share';
  static const String titleLanguage = 'title_language';
  static const String titleTheme = 'title_theme';
  static const String titleAuthor = 'title_author';
  static const String titleOther = 'title_other';

  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageEN = 'language_en';

  static const String save = 'save';
  static const String more = 'more';

  static const String recProject = 'rec_Project';
  static const String recWxArticle = 'rec_wxarticle';

  static const String titleProjectTree = 'title_Project_tree';
  static const String titleWxArticleTree = 'title_wxarticle_tree';
  static const String titleSystemTree = 'title_system_tree';

  static const String confirm = 'confirm';
  static const String cancel = 'cancel';

  static const String jump_count = 'jump_count';
}

Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    Ids.titleHome: 'Home',
    Ids.titleProject: 'Project',
    Ids.titleDynamic: 'Dynamic',
    Ids.titleSystem: 'System',
    Ids.titleBookmarks: 'Bookmarks',
    Ids.titleSetting: 'Setting',
    Ids.titleAbout: 'About',
    Ids.titleShare: 'Share',
    Ids.titleLanguage: 'Language',
    Ids.languageAuto: 'Auto',
  },
  'zh': {
    Ids.titleHome: '主页',
    Ids.titleProject: '项目',
    Ids.titleDynamic: '动态',
    Ids.titleSystem: '体系',
    Ids.titleBookmarks: '书签',
    Ids.titleSetting: '设置',
    Ids.titleAbout: '关于',
    Ids.titleShare: '分享',
    Ids.titleLanguage: '多语言',
    Ids.languageAuto: '跟随系统',
  },
};

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {
      Ids.titleHome: 'Home',
      Ids.titleProject: 'Project',
      Ids.titleDynamic: 'Dynamic',
      Ids.titleSystem: 'System',
      Ids.titleBookmarks: 'Bookmarks',
      Ids.titleCollect: 'Collect',
      Ids.titleSetting: 'Setting',
      Ids.titleAbout: 'About',
      Ids.titleShare: 'Share',
      Ids.titleLanguage: 'Language',
      Ids.languageAuto: 'Auto',
      Ids.save: 'Save',
      Ids.more: 'More',
      Ids.recProject: 'Reco Project',
      Ids.recWxArticle: 'Reco WxArticle',
      Ids.titleProjectTree: 'Project Tree',
      Ids.titleWxArticleTree: 'Wx Article',
      Ids.titleTheme: 'Theme',
      Ids.confirm: 'Confirm',
      Ids.cancel: 'Cancel',
      Ids.jump_count: 'Jump %\$0\$s',
    }
  },
  'zh': {
    'CN': {
      Ids.titleHome: '主页',
      Ids.titleProject: '项目',
      Ids.titleDynamic: '动态',
      Ids.titleSystem: '体系',
      Ids.titleBookmarks: '书签',
      Ids.titleCollect: '收藏',
      Ids.titleSetting: '设置',
      Ids.titleAbout: '关于',
      Ids.titleShare: '分享',
      Ids.titleLanguage: '多语言',
      Ids.languageAuto: '跟随系统',
      Ids.languageZH: '简体中文',
      Ids.languageEN: 'English',
      Ids.save: '保存',
      Ids.more: '更多',
      Ids.recProject: '推荐项目',
      Ids.recWxArticle: '推荐公众号',
      Ids.titleProjectTree: '项目分类',
      Ids.titleWxArticleTree: '公众号',
      Ids.titleTheme: '主题',
      Ids.confirm: '确认',
      Ids.cancel: '取消',
      Ids.jump_count: '跳过 %\$0\$s',
    },
  }
};
