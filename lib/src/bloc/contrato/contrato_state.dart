part of 'contrato_bloc.dart';

enum ContratoStatus { initial, loading, success, error }

class ContratoState extends Equatable {
  final Map<dynamic, Contrato> contratos;
  final double total;
  final ContratoStatus status;

  const ContratoState(
      {this.contratos = const {},
      this.total = 0,
      this.status = ContratoStatus.initial});

  factory ContratoState.initalState() => const ContratoState();

  ContratoState copyWith(
          {Map<dynamic, Contrato>? contratos,
          double? total,
          ContratoStatus? status}) =>
      ContratoState(
          contratos: contratos ?? this.contratos,
          status: status ?? this.status,
          total: total ?? this.total);

  @override
  List<Object> get props => [contratos, total, status];
}

// class ContratoInitial extends ContratoState {
//   const ContratoInitial() : super(contratos: null, total: 0);
// }

// class ContratoLoadingState extends ContratoState {
//   const ContratoLoadingState() : super(contratos: null, total: 0);
// }

// class ContratoSuccessState extends ContratoState {
//   final Map<dynamic, Contrato> newContratos;
//   final double newTotal;
//   const ContratoSuccessState(this.newContratos, this.newTotal)
//       : super(contratos: newContratos, total: newTotal);
// }
