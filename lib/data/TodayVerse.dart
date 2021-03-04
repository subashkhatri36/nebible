class Detail {
  String book;
  String nbook;
  int chapter;
  int fromverse;
  int toverse;
  String nepverse;
  String engverse;
  Detail(
      {this.book,
      this.nbook,
      this.chapter,
      this.fromverse,
      this.toverse,
      this.nepverse,
      this.engverse});
}

List<Detail> todayverse = [
  Detail(
      book: 'Gen',
      nbook: 'afdas',
      chapter: 0,
      fromverse: 0,
      toverse: 0,
      nepverse:
          'Now when Jesus saw the crowds, he went up on a mountainside and sat down',
      engverse:
          'Now when Jesus saw the crowds, he went up on a mountainside and sat down'),
  Detail(
      book: 'Matthew',
      nbook: 'nepali',
      chapter: 5,
      fromverse: 1,
      toverse: 3,
      nepverse: 'this is nepali',
      engverse:
          'Now when Jesus saw the crowds, he went up on a mountainside and sat down. His disciples came to him, and he began to teach them. He said: “Blessed are the poor in spirit, for theirs is the kingdom of heaven.'),
  Detail(
      book: 'Psalm',
      nbook: 'np',
      chapter: 73,
      fromverse: 26,
      toverse: 0,
      nepverse: 'np my heart may fail, but God is the strength of my heart ',
      engverse:
          'My flesh and my heart may fail, but God is the strength of my heart and my portion forever.')
];
