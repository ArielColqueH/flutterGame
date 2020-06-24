//objeto para datos de jugador
class Jugador{
  String _nombre;
  int _score;
  Jugador(this._nombre,this._score);

  int get score => _score;

  set score(int value) {
    _score = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

}