import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Question1', [
      'An army or navy emblem',
      'Crumbling cliffs',
      'A bat',
      'Nothing at all',
      'Two people',
      'A pelvis',
      'An X-ray picture',
      'Pincers of a crab',
      'A dirty mess',
      'Part of my body',
      'Something not listed here'
    ]),
    Question('Question2', [
      'A bug somebody stepped on',
      'Nothing at all',
      'Two scottie dogs',
      'Little faces on the sides',
      'A bloody spinal column',
      'A white top',
      'A bursting bomb',
      'Two elephants',
      'Two clowns',
      'Black and red',
      'Something not listed here'
    ]),
    Question('Question3', [
      'Two birds',
      'Meat in a butcher shop',
      'Two men',
      'Part of my body',
      'Red and black',
      'A colored butterfly',
      'Spots of blood and paint',
      'Monkeys hanging by their tails',
      'A red bow-tie',
      'Nothing at all',
      'Something not listed here'
    ]),
    Question('Question4', [
      'Head of animal',
      'Lungs and chest',
      'A nasty mess',
      'A pair of boots',
      'Black smoke and dirt',
      'Nothing at all',
      'A man in a fur coat',
      'An animal skin',
      'A big gorilla',
      'An X-ray picture',
      'Something not listed here'
    ]),
    Question('Question5', [
      'Nothing at all',
      'An alligator\'s head',
      'A smashed body',
      'A fan dancer',
      'An x-ray picture',
      'Legs',
      'A bat or butterfly',
      'Lungs and chest',
      'Black clouds',
      'A pair of pliers',
      'Something not listed here'
    ]),
    Question('Question6', [
      'Two kings\' crowns',
      'An x-ray picture',
      'Sex organs',
      'A totem pole',
      'A fur rug',
      'Mud and water',
      'A polished post',
      'Nothing at all',
      'A turtle',
      'A gray smudge',
      'Something not listed here'
    ]),
    Question('Question7', [
      'Smoke or clouds',
      'Two women talking',
      'Part of my body',
      'Animals or animal heads',
      'Nothing at all',
      'A map',
      'Dirty ice and snow',
      'Lamb\'s tails, or feathers',
      'An x-ray picture',
      'Bookends',
      'Something not listed here'
    ]),
    Question('Question8', [
      'Flowers or leaves',
      'An x-ray picture',
      'Nothing at all',
      'Pink, blue and orange',
      'A horseshoe crab',
      'A colored coat of arms',
      'Fire and ice, life and death',
      'Two animals',
      'Blue flags',
      'Parts of my body',
      'Something not listed here'
    ]),
    Question('Question9', [
      'Red, green, and orange',
      'Sea horses, or lobsters',
      'Flowers or underwater vegetation',
      'Parts of my body',
      'Smoke, flames, or an explosion',
      'Deer or horns of a deer',
      'Nothing at all',
      'Two people-witches or Santa Clauses',
      'Bloody clouds',
      'A candle',
      'Something not listed here'
    ]),
    Question('Question10', [
      'Two people',
      'Split paint',
      'A Chinese print',
      'An x-ray picture',
      'Red, blue, or green',
      'Spider, caterpillars, crabs and insects',
      'Parts of my insides',
      'A colored chart or map',
      'Nothing at all',
      'A flower garden or gay tropical fish',
      'Something not listed here'
    ]),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  List getOptionsList() {
    return _questionBank[_questionNumber].answers;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
