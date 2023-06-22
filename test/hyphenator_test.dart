import 'dart:math' as Math show min, max;

import 'package:flutter_test/flutter_test.dart';
import 'package:hyphenator_impure/hyphenator.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final resource =
      await DefaultResourceLoader.load(DefaultResourceLoaderLanguage.enUs);

  test('patterns', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
    );

    expect(hyphenator.hyphenate('subdivision'), 'sub_di_vi_sion');
    expect(hyphenator.hyphenate('creative'), 'cre_ative');
    expect(hyphenator.hyphenate('disciplines'), 'dis_ci_plines');
  });

  test('hyphenate word to list', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
    );

    expect(hyphenator.hyphenateWordToList('subdivision'), <String>['sub', 'di', 'vi', 'sion']);
    expect(hyphenator.hyphenateWordToList('creative'), <String>['cre', 'ative']);
    expect(hyphenator.hyphenateWordToList('disciplines'), <String>['dis', 'ci', 'plines']);
  });

  test('hyphenate word to list, punctuation', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
    );

    expect(hyphenator.hyphenateWordToList('"subdivision"'), <String>['"sub', 'di', 'vi', 'sion"']);
    expect(hyphenator.hyphenateWordToList('creative...'), <String>['cre', 'ative...']);
    expect(hyphenator.hyphenateWordToList('disciplines,'), <String>['dis', 'ci', 'plines,']);
  });

  test('exceptions', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
    );

    expect(hyphenator.hyphenate('philanthropic'), 'phil_an_thropic');
  });

  test('text', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '-',
    );

    final text =
        '''The arts are a vast subdivision of culture, composed of many creative endeavors and disciplines. It is a broader term than "art", which as a description of a field usually means only the visual arts. The arts encompass the visual arts, the literary arts and the performing arts – music, theatre, dance and film, among others. This list is by no means comprehensive, but only meant to introduce the concept of the arts. For all intents and purposes, the history of the arts begins with the history of art. The arts might have origins in early human evolutionary prehistory. According to a recent suggestion, several forms of audio and visual arts (rhythmic singing and drumming on external objects, dancing, body and face painting) were developed very early in hominid evolution by the forces of natural selection in order to reach an altered state of consciousness. In this state, which Jordania calls battle trance, hominids and early human were losing their individuality, and were acquiring a new collective identity, where they were not feeling fear or pain, and were religiously dedicated to the group interests, in total disregards of their individual safety and life. This state was needed to defend early hominids from predators, and also to help to obtain food by aggressive scavenging. Ritualistic actions involving heavy rhythmic music, rhythmic drill, coupled sometimes with dance and body painting had been universally used in traditional cultures before the hunting or military sessions in order to put them in a specific altered state of consciousness and raise the morale of participants.''';
    final expectedText =
        '''The arts are a vast sub-di-vi-sion of cul-ture, com-posed of many cre-ative endeav-ors and dis-ci-plines. It is a broader term than "art", which as a descrip-tion of a field usu-ally means only the visual arts. The arts encom-pass the visual arts, the lit-er-ary arts and the per-form-ing arts – music, the-atre, dance and film, among others. This list is by no means com-pre-hen-sive, but only meant to intro-duce the con-cept of the arts. For all intents and pur-poses, the his-tory of the arts begins with the his-tory of art. The arts might have ori-gins in early human evo-lu-tion-ary pre-his-tory. Accord-ing to a recent sugges-tion, sev-eral forms of audio and visual arts (rhyth-mic sing-ing and drum-ming on exter-nal objects, danc-ing, body and face paint-ing) were devel-oped very early in hominid evo-lu-tion by the forces of nat-ural selec-tion in order to reach an altered state of con-scious-ness. In this state, which Jor-da-nia calls bat-tle trance, hominids and early human were los-ing their indi-vid-u-al-ity, and were acquir-ing a new col-lec-tive iden-tity, where they were not feel-ing fear or pain, and were reli-giously ded-i-cated to the group inter-ests, in total dis-re-gards of their indi-vid-ual safety and life. This state was needed to defend early hominids from preda-tors, and also to help to obtain food by aggres-sive scaveng-ing. Rit-u-al-is-tic actions involv-ing heavy rhyth-mic music, rhyth-mic drill, cou-pled some-times with dance and body paint-ing had been uni-ver-sally used in tra-di-tional cul-tures before the hunt-ing or mil-i-tary ses-sions in order to put them in a spe-cific altered state of con-scious-ness and raise the morale of par-tic-i-pants.''';

    expect(hyphenator.hyphenate(text), expectedText);
  });

  test('min letter count', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
      minLetterCount: 4,
    );

    expect(hyphenator.hyphenate('disciplines'), 'disci_plines');
  });

  test('min letter count dont raise', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
      minLetterCount: 50,
    );

    expect(hyphenator.hyphenate('disciplines'), 'disciplines');
  });

  test('min word length', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
      minWordLength: 50,
    );

    expect(hyphenator.hyphenate('disciplines'), 'disciplines');
  });

  test('min word length', () async {
    final hyphenator = Hyphenator(
      resource: resource,
      hyphenateSymbol: '_',
      minWordLength: 50,
    );

    final text =
        '''The arts are a vast subdivision of culture, composed of many 
        creative endeavors and disciplines. It is a broader term than "art", 
        which as a description of a field usually means only the visual arts. 
        The arts encompass the visual arts, the literary arts and the performing 
        arts – music, theatre, dance and film, among others. This list is by no 
        means comprehensive, but only meant to introduce the concept of the 
        arts. For all intents and purposes, the history of the arts begins with the 
        history of art. The arts might have origins in early human evolutionary 
        prehistory. According to a recent suggestion, several forms of audio 
        and visual arts (rhythmic singing and drumming on external objects, 
        dancing, body and face painting) were developed very early in hominid 
        evolution by the forces of natural selection in order to reach an 
        altered state of consciousness. In this state, which Jordania calls 
        battle trance, hominids and early human were losing their individuality, 
        and were acquiring a new collective identity, where they were not 
        feeling fear or pain, and were religiously dedicated to the group 
        interests, in total disregards of their individual safety and life. 
        This state was needed to defend early hominids from predators, and 
        also to help to obtain food by aggressive scavenging. Ritualistic 
        actions involving heavy rhythmic music, rhythmic drill, coupled 
        sometimes with dance and body painting had been universally used in 
        traditional cultures before the hunting or military sessions in order 
        to put them in a specific altered state of consciousness and raise the 
        morale of participants.''';

    final stopWatches = <int>[];

    for (int i = 0; i < 200; i++) {
      final startNew = Stopwatch()..start();
      hyphenator.hyphenate(text);
      startNew.stop();

      stopWatches.add(startNew.elapsedMicroseconds);
    }

    final avg = stopWatches.reduce((a, b) => a + b) / stopWatches.length;
    final min = stopWatches.reduce(Math.min);
    final max = stopWatches.reduce(Math.max);
    print('''
In micro:
 min: $min
 max: $max
 avr: ${avg.toStringAsFixed(2)}
''');
  });
}
